#
#  (C) Copyright 2019-2020 HP Development Company, L.P.
#  Confidential computer software. Valid license from HP required for possession, use or copying.
#  Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
#  Computer Software Documentation, and Technical Data for Commercial Items are licensed
#  to the U.S. Government under vendor's standard commercial license.
#

import os
import sys
import json

from http.client import HTTPSConnection
from base64 import b64encode
from urllib.parse import urlparse
from urllib.parse import quote

ADO_URL = 'https://dev.azure.com'
ADO_ORG = 'hpcodeway'

project          = sys.argv[1]
variable_group   = sys.argv[2]
variable_prefix  = sys.argv[3]
role_arn         = sys.argv[4]
external_id      = sys.argv[5]

try:
    token = os.environ['ADO_TOKEN']
    auth = b64encode(f':{token}'.encode()).decode('ascii')
    headers = {'Content-type': 'application/json', 'Authorization': f'Basic {auth}'}

    uri = urlparse(ADO_URL)
    conn = HTTPSConnection(uri.hostname)

    print(f'Get variable group {variable_group} for {project}')
    path = f'/{ADO_ORG}/{quote(project)}/_apis/distributedtask/variablegroups?groupName={quote(variable_group)}'
    conn.request('GET', path, headers=headers)

    response = conn.getresponse()
    if response.status != 200:
        print(f'Failed to get variable group. Response ({response.status}): {response.reason}')
        sys.exit(1)

    data = json.loads(response.read().decode('utf-8'))

    if variable_prefix:
        role_arn_var = f'{variable_prefix}_role_arn'
        external_id_var = f'{variable_prefix}_external_id'
    else:
        role_arn_var = 'role_arn'
        external_id_var = 'external_id'

    if data['count'] > 0:
        variable_group_id = data['value'][0]['id']
        print(f'Variable group found and its id is: {variable_group_id}')

        variables =  {
            f'{role_arn_var}': {
                'value': role_arn,
                'isSecret': True
            },
            f'{external_id_var}': {
                'value': external_id,
                'isSecret': True
            },
        }

        data['value'][0]['variables'].update(variables)

        print(f'Update variable group {variable_group} with variables {role_arn_var} and {external_id_var}')
        path = f'/{ADO_ORG}/{quote(project)}/_apis/distributedtask/variablegroups/{variable_group_id}?api-version=6.0-preview.1'
        conn.request('PUT', path, body=json.dumps(data['value'][0]), headers=headers)

        response = conn.getresponse()
        if response.status != 200:
            print(f'Failed to update variable group. Response ({response.status}): {response.reason}')
            sys.exit(1)

        data = json.loads(response.read().decode('utf-8'))
        print(response.status)
        print(data)
    else:
        print('Variable group not found, creating one...')
        data =  {
            'variables': {
                f'{role_arn_var}': {
                    'value': role_arn,
                    'isSecret': True
                },
                f'{external_id_var}': {
                    'value': external_id,
                    'isSecret': True
                },
            },
            'type': 'Vsts',
            'name': variable_group,
            'description': f'Variable group for holding role arn and external id for {variable_prefix}',
        }

        print(f'Create new variable group {variable_group} with new variables {role_arn_var} and {external_id_var}')
        path = f'/{ADO_ORG}/{quote(project)}/_apis/distributedtask/variablegroups?api-version=6.0-preview.1'
        conn.request('POST', path, body=json.dumps(data), headers=headers)

        response = conn.getresponse()
        if response.status != 200:
            print(f'Failed to create variable group. Response ({response.status}): {response.reason}')
            sys.exit(1)

        data = json.loads(response.read().decode('utf-8'))
        print(response.status)
        print(data)

except KeyError:
    print('Please set the environment variable ADO_TOKEN')
    sys.exit(1)

except Exception as e:
    print(f'Failed to run the script: {e}')

conn.close()
response.close()
