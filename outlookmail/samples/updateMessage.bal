// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/log;
import ballerinax/microsoft.outlook.mail;

configurable string & readonly refreshUrl = ?;
configurable string & readonly refreshToken = ?;
configurable string & readonly clientId = ?;
configurable string & readonly clientSecret = ?;

mail:Configuration configuration = {clientConfig: {
        refreshUrl: refreshUrl,
        refreshToken: refreshToken,
        clientId: clientId,
        clientSecret: clientSecret
    }};

mail:Client outlookClient = check new (configuration);

public function main() returns error? {
    mail:MessageUpdateContent message = {
        subject:"Update Subject",
        importance:"Low",
        body:{
            contentType: "HTML",
            content: "Updated Content<b>Test</b>!"
        }
    };
    mail:Message updatedMessage = check outlookClient->updateMessage("<messageId>", message, "<Folder ID>");
    log:printInfo(updatedMessage?.subject.toString());
}


