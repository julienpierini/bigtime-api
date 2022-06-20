import datetime
import json
import boto3

# client
ses = boto3.client("ses")


def handler(event, context):
    if event.get("httpMethod") == "GET" and event.get("path") == "/currentTime":
        try:
            # return time
            d = {"currentTime" :datetime.datetime.now().__str__()}
            return {
                "statusCode": 200,
                "body": json.dumps(d)
            }
        except as err:
            # if an error occur send email to incredible@ops.bigtimeapi.com
            # The subject line for the email.
            SUBJECT = "Error from bigtime Apigateway"

            # The email body for recipients with non-HTML email clients.
            BODY_TEXT = "This email was sent because an error occur when executing bigtime API Gateway:\n{}".format(err)
                        
            # The HTML body of the email.
            BODY_HTML = """<html>
            <head></head>
            <body>
            <h1>Error from bigtimeapi Apigateway execution</h1>
            <p>This email was sent because an error occur when executing bigtime API Gateway:
            {}
            </p>
            </body>
            </html>""".format(err)            

            # The character encoding for the email.
            CHARSET = "UTF-8"

            client.send_email(
                Destination={
                    'ToAddresses': [
                        RECIPIENT,
                    ],
                },
                Message={
                    'Body': {
                        'Html': {
                            'Charset': CHARSET,
                            'Data': BODY_HTML,
                        },
                        'Text': {
                            'Charset': CHARSET,
                            'Data': BODY_TEXT,
                        },
                    },
                    'Subject': {
                        'Charset': CHARSET,
                        'Data': SUBJECT,
                    },
                },
                Source="bigtimeapi@bigtimeapi.com",
            )