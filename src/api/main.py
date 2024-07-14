import json

def handler(event, context):

    action_name = None
    
    if event.get('queryStringParameters') is not None:
        action_name = event['queryStringParameters'].get('action_name')

    
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Hello, World!",
        }),
    }