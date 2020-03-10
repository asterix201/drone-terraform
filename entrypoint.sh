#!/bin/bash
/bin/yandex-cloud/bin/yc config profile create sa-profile
/bin/yandex-cloud/bin/yc config set service-account-key ${YC_SERVICE_ACCOUNT_KEY_FILE}
/bin/drone-terraform $@
