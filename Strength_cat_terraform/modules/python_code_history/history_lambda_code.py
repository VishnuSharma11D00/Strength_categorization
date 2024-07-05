import json
import decimal
import boto3
import os
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
table_name = os.environ['DYNAMODB_TABLE_NAME']  # Replace with your DynamoDB table name
table = dynamodb.Table(table_name)

# Helper function to convert DynamoDB items to JSON
def decimal_default(obj):
    if isinstance(obj, decimal.Decimal):
        return float(obj)
    raise TypeError

def lambda_handler(event, context):
    if 'queryStringParameters' not in event or 'username' not in event['queryStringParameters']:
        return {
            'statusCode': 400,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({'error': 'Missing username parameter'})
        }
    
    username = event['queryStringParameters']['username']
    response = table.query(
        KeyConditionExpression=Key('username').eq(username)
    )
    
    # Convert Decimal types to float for JSON serialization
    items = response['Items']
    for item in items:
        for key, value in item.items():
            if isinstance(value, decimal.Decimal):
                item[key] = float(value)
    
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps(items, default=decimal_default)
    }
