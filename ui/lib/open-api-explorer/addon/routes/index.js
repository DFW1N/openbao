/**
 * Copyright (c) HashiCorp, Inc.
 * SPDX-License-Identifier: BUSL-1.1
 */

import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';

export default class OpenApiExplorerIndex extends Route {
  @service flashMessages;

  afterModel() {
    const warning = `The "Try it out" functionality in this API explorer will make requests to this OpenBao server on your behalf.

IF YOUR TOKEN HAS THE PROPER CAPABILITIES, THIS WILL CREATE AND DELETE ITEMS ON THE OPENBAO SERVER.

Your token will also be shown on the screen in the example curl command output.`;
    this.flashMessages.warning(warning, {
      sticky: true,
      preformatted: true,
    });
  }
}
