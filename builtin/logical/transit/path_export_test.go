// Copyright (c) HashiCorp, Inc.
// SPDX-License-Identifier: BUSL-1.1

package transit

import (
	"context"
	"fmt"
	"reflect"
	"strconv"
	"strings"
	"testing"

	"github.com/openbao/openbao/sdk/logical"
)

func TestTransit_Export_Unknown_ExportType(t *testing.T) {
	t.Parallel()

	b, storage := createBackendWithSysView(t)
	keyType := "ed25519"
	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
		Data: map[string]interface{}{
			"exportable": true,
			"type":       keyType,
		},
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatalf("failed creating key %s: %v", keyType, err)
	}

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.ReadOperation,
		Path:      "export/bad-export-type/foo",
	}
	rsp, err := b.HandleRequest(context.Background(), req)
	if err == nil {
		t.Fatalf("did not error on bad export type got: %v", rsp)
	}
	if rsp == nil || !rsp.IsError() {
		t.Fatalf("response did not contain an error on bad export type got: %v", rsp)
	}
	if !strings.Contains(rsp.Error().Error(), "invalid export type") {
		t.Fatalf("failed with unexpected error: %v", err)
	}
}

func TestTransit_Export_KeyVersion_ExportsCorrectVersion(t *testing.T) {
	t.Parallel()

	verifyExportsCorrectVersion(t, "encryption-key", "aes128-gcm96")
	verifyExportsCorrectVersion(t, "encryption-key", "aes256-gcm96")
	verifyExportsCorrectVersion(t, "encryption-key", "chacha20-poly1305")
	verifyExportsCorrectVersion(t, "encryption-key", "xchacha20-poly1305")
	verifyExportsCorrectVersion(t, "encryption-key", "rsa-2048")
	verifyExportsCorrectVersion(t, "encryption-key", "rsa-3072")
	verifyExportsCorrectVersion(t, "encryption-key", "rsa-4096")
	verifyExportsCorrectVersion(t, "signing-key", "ecdsa-p256")
	verifyExportsCorrectVersion(t, "signing-key", "ecdsa-p384")
	verifyExportsCorrectVersion(t, "signing-key", "ecdsa-p521")
	verifyExportsCorrectVersion(t, "signing-key", "ed25519")
	verifyExportsCorrectVersion(t, "signing-key", "rsa-2048")
	verifyExportsCorrectVersion(t, "signing-key", "rsa-3072")
	verifyExportsCorrectVersion(t, "signing-key", "rsa-4096")
	verifyExportsCorrectVersion(t, "hmac-key", "aes128-gcm96")
	verifyExportsCorrectVersion(t, "hmac-key", "aes256-gcm96")
	verifyExportsCorrectVersion(t, "hmac-key", "chacha20-poly1305")
	verifyExportsCorrectVersion(t, "hmac-key", "xchacha20-poly1305")
	verifyExportsCorrectVersion(t, "hmac-key", "ecdsa-p256")
	verifyExportsCorrectVersion(t, "hmac-key", "ecdsa-p384")
	verifyExportsCorrectVersion(t, "hmac-key", "ecdsa-p521")
	verifyExportsCorrectVersion(t, "hmac-key", "ed25519")
	verifyExportsCorrectVersion(t, "hmac-key", "hmac")
	verifyExportsCorrectVersion(t, "public-key", "rsa-2048")
	verifyExportsCorrectVersion(t, "public-key", "rsa-3072")
	verifyExportsCorrectVersion(t, "public-key", "rsa-4096")
	verifyExportsCorrectVersion(t, "public-key", "ecdsa-p256")
	verifyExportsCorrectVersion(t, "public-key", "ecdsa-p384")
	verifyExportsCorrectVersion(t, "public-key", "ecdsa-p521")
	verifyExportsCorrectVersion(t, "public-key", "ed25519")
}

func verifyExportsCorrectVersion(t *testing.T, exportType, keyType string) {
	b, storage := createBackendWithSysView(t)

	// First create a key, v1
	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
	}
	req.Data = map[string]interface{}{
		"exportable": true,
		"type":       keyType,
	}
	if keyType == "hmac" {
		req.Data["key_size"] = 32
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	verifyVersion := func(versionRequest string, expectedVersion int) {
		req := &logical.Request{
			Storage:   storage,
			Operation: logical.ReadOperation,
			Path:      fmt.Sprintf("export/%s/foo/%s", exportType, versionRequest),
		}
		rsp, err := b.HandleRequest(context.Background(), req)
		if err != nil {
			t.Fatal(err)
		}

		typRaw, ok := rsp.Data["type"]
		if !ok {
			t.Fatal("no type returned from export")
		}
		typ, ok := typRaw.(string)
		if !ok {
			t.Fatalf("could not find key type, resp data is %#v", rsp.Data)
		}
		if typ != keyType {
			t.Fatalf("key type mismatch; %q vs %q", typ, keyType)
		}

		keysRaw, ok := rsp.Data["keys"]
		if !ok {
			t.Fatal("could not find keys value")
		}
		keys, ok := keysRaw.(map[string]string)
		if !ok {
			t.Fatal("could not cast to keys map")
		}
		if len(keys) != 1 {
			t.Fatal("unexpected number of keys found")
		}

		for k := range keys {
			if k != strconv.Itoa(expectedVersion) {
				t.Fatalf("expected version %q, received version %q", strconv.Itoa(expectedVersion), k)
			}
		}
	}

	verifyVersion("v1", 1)
	verifyVersion("1", 1)
	verifyVersion("latest", 1)

	req.Path = "keys/foo/rotate"
	// v2
	_, err = b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	verifyVersion("v1", 1)
	verifyVersion("1", 1)
	verifyVersion("v2", 2)
	verifyVersion("2", 2)
	verifyVersion("latest", 2)

	// v3
	_, err = b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	verifyVersion("v1", 1)
	verifyVersion("1", 1)
	verifyVersion("v3", 3)
	verifyVersion("3", 3)
	verifyVersion("latest", 3)
}

func TestTransit_Export_ValidVersionsOnly(t *testing.T) {
	t.Parallel()

	b, storage := createBackendWithSysView(t)

	// First create a key, v1
	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
	}
	req.Data = map[string]interface{}{
		"exportable": true,
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	req.Path = "keys/foo/rotate"
	// v2
	_, err = b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}
	// v3
	_, err = b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	verifyExport := func(validVersions []int) {
		req = &logical.Request{
			Storage:   storage,
			Operation: logical.ReadOperation,
			Path:      "export/encryption-key/foo",
		}
		rsp, err := b.HandleRequest(context.Background(), req)
		if err != nil {
			t.Fatal(err)
		}
		if _, ok := rsp.Data["keys"]; !ok {
			t.Error("no keys returned from export")
		}

		keys, ok := rsp.Data["keys"].(map[string]string)
		if !ok {
			t.Error("could not cast to keys object")
		}
		if len(keys) != len(validVersions) {
			t.Errorf("expected %d key count, received %d", len(validVersions), len(keys))
		}
		for _, version := range validVersions {
			if _, ok := keys[strconv.Itoa(version)]; !ok {
				t.Errorf("expecting to find key version %d, not found", version)
			}
		}
	}

	verifyExport([]int{1, 2, 3})

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo/config",
	}
	req.Data = map[string]interface{}{
		"min_decryption_version": 3,
	}
	_, err = b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}
	verifyExport([]int{3})

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo/config",
	}
	req.Data = map[string]interface{}{
		"min_decryption_version": 2,
	}
	_, err = b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}
	verifyExport([]int{2, 3})

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo/rotate",
	}
	// v4
	_, err = b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}
	verifyExport([]int{2, 3, 4})
}

func TestTransit_Export_KeysNotMarkedExportable_ReturnsError(t *testing.T) {
	t.Parallel()

	b, storage := createBackendWithSysView(t)

	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
	}
	req.Data = map[string]interface{}{
		"exportable": false,
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.ReadOperation,
		Path:      "export/encryption-key/foo",
	}
	rsp, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}
	if !rsp.IsError() {
		t.Fatal("Key not marked as exportable but was exported.")
	}
}

func TestTransit_Export_SigningDoesNotSupportSigning_ReturnsError(t *testing.T) {
	t.Parallel()

	b, storage := createBackendWithSysView(t)

	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
	}
	req.Data = map[string]interface{}{
		"exportable": true,
		"type":       "aes256-gcm96",
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.ReadOperation,
		Path:      "export/signing-key/foo",
	}
	_, err = b.HandleRequest(context.Background(), req)
	if err == nil {
		t.Fatal("Key does not support signing but was exported without error.")
	}
}

func TestTransit_Export_EncryptionDoesNotSupportEncryption_ReturnsError(t *testing.T) {
	t.Parallel()

	testTransit_Export_EncryptionDoesNotSupportEncryption_ReturnsError(t, "ecdsa-p256")
	testTransit_Export_EncryptionDoesNotSupportEncryption_ReturnsError(t, "ecdsa-p384")
	testTransit_Export_EncryptionDoesNotSupportEncryption_ReturnsError(t, "ecdsa-p521")
	testTransit_Export_EncryptionDoesNotSupportEncryption_ReturnsError(t, "ed25519")
}

func testTransit_Export_EncryptionDoesNotSupportEncryption_ReturnsError(t *testing.T, keyType string) {
	b, storage := createBackendWithSysView(t)

	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
	}
	req.Data = map[string]interface{}{
		"exportable": true,
		"type":       keyType,
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.ReadOperation,
		Path:      "export/encryption-key/foo",
	}
	_, err = b.HandleRequest(context.Background(), req)
	if err == nil {
		t.Fatalf("Key %s does not support encryption but was exported without error.", keyType)
	}
}

func TestTransit_Export_PublicKeyDoesNotSupportEncryption_ReturnsError(t *testing.T) {
	t.Parallel()

	testTransit_Export_PublicKeyNotSupported_ReturnsError(t, "chacha20-poly1305")
	testTransit_Export_PublicKeyNotSupported_ReturnsError(t, "xchacha20-poly1305")
	testTransit_Export_PublicKeyNotSupported_ReturnsError(t, "aes128-gcm96")
	testTransit_Export_PublicKeyNotSupported_ReturnsError(t, "aes256-gcm96")
	testTransit_Export_PublicKeyNotSupported_ReturnsError(t, "hmac")
}

func testTransit_Export_PublicKeyNotSupported_ReturnsError(t *testing.T, keyType string) {
	b, storage := createBackendWithSysView(t)

	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
		Data: map[string]interface{}{
			"type": keyType,
		},
	}
	if keyType == "hmac" {
		req.Data["key_size"] = 32
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatalf("failed creating key %s: %v", keyType, err)
	}

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.ReadOperation,
		Path:      "export/public-key/foo",
	}
	_, err = b.HandleRequest(context.Background(), req)
	if err == nil {
		t.Fatalf("Key %s does not support public key exporting but was exported without error.", keyType)
	}
	if !strings.Contains(err.Error(), fmt.Sprintf("unknown key type %s for export type public-key", keyType)) {
		t.Fatalf("unexpected error value for key type: %s: %v", keyType, err)
	}
}

func TestTransit_Export_KeysDoesNotExist_ReturnsNotFound(t *testing.T) {
	t.Parallel()

	b, storage := createBackendWithSysView(t)

	req := &logical.Request{
		Storage:   storage,
		Operation: logical.ReadOperation,
		Path:      "export/encryption-key/foo",
	}
	rsp, err := b.HandleRequest(context.Background(), req)

	if !(rsp == nil && err == nil) {
		t.Fatal("Key does not exist but does not return not found")
	}
}

func TestTransit_Export_EncryptionKey_DoesNotExportHMACKey(t *testing.T) {
	t.Parallel()

	b, storage := createBackendWithSysView(t)

	req := &logical.Request{
		Storage:   storage,
		Operation: logical.UpdateOperation,
		Path:      "keys/foo",
	}
	req.Data = map[string]interface{}{
		"exportable": true,
		"type":       "aes256-gcm96",
	}
	_, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	req = &logical.Request{
		Storage:   storage,
		Operation: logical.ReadOperation,
		Path:      "export/encryption-key/foo",
	}
	encryptionKeyRsp, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}
	req.Path = "export/hmac-key/foo"
	hmacKeyRsp, err := b.HandleRequest(context.Background(), req)
	if err != nil {
		t.Fatal(err)
	}

	encryptionKeys, ok := encryptionKeyRsp.Data["keys"].(map[string]string)
	if !ok {
		t.Error("could not cast to keys object")
	}
	hmacKeys, ok := hmacKeyRsp.Data["keys"].(map[string]string)
	if !ok {
		t.Error("could not cast to keys object")
	}
	if len(hmacKeys) != len(encryptionKeys) {
		t.Errorf("hmac (%d) and encryption (%d) key count don't match",
			len(hmacKeys), len(encryptionKeys))
	}

	if reflect.DeepEqual(encryptionKeyRsp.Data, hmacKeyRsp.Data) {
		t.Fatal("Encryption key data matched hmac key data")
	}
}
