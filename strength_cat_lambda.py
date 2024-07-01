
import boto3
from datetime import datetime
from decimal import Decimal

# Initialize DynamoDB client and table
dynamodb = boto3.resource('dynamodb')
table_name = 'strength_cat_dynamodb'  # Replace with your DynamoDB table name
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    username = event['username']
    gender = event['gender']
    bw = float(event['bw'])
    squat = float(event['squat'])
    bench = float(event['bench'])
    deadlift = float(event['deadlift'])
    unit = event.get('unit', 'kg')  # Default to 'kg' if unit is not provided in event
    
    result = categorize_strength(gender, bw, squat, bench, deadlift, unit)
    
    # Generate current timestamp
    timestamp = datetime.now().isoformat()
    
    # Convert float values to Decimal
    bw = Decimal(str(bw))
    squat = Decimal(str(squat))
    bench = Decimal(str(bench))
    deadlift = Decimal(str(deadlift))
    
    # Store the results in DynamoDB
    table.put_item(
        Item={
            'username': username,
            'timestamp': timestamp,
            'gender': gender,
            'bodyweight': bw,
            'squat': squat,
            'bench': bench,
            'deadlift': deadlift,
            'squat_category': result[0],
            'bench_category': result[1],
            'deadlift_category': result[2]
        }
    )
    
    return {
        'statusCode': 200,
        'body': {
            'Squat': result[0],
            'Bench': result[1],
            'Deadlift': result[2]
        }
    }

def categorize_strength(gender, bw, squat, bench, deadlift, unit='kg'):
    # Define strength standards for male and female as ranges
    standards = {
        "male": {
            "squat": [(0, 1.25), (1.25, 1.75), (1.75, 2.5), (2.5, 3)],
            "bench": [(0, 1.0), (1.0, 1.5), (1.5, 2.0), (2.0, 2.25)],
            "deadlift": [(0, 1.5), (1.5, 2.25), (2.25, 3.0), (3.0, 3.5)]
        },
        "female": {
            "squat": [(0, 0.5), (0.5, 1.0), (1.0, 1.5), (1.5, 2.25)],
            "bench": [(0, 0.5), (0.5, 0.75), (0.75, 1.0), (1.0, 1.25)],
            "deadlift": [(0, 0.5), (0.5, 1.25), (1.25, 1.75), (1.75, 2.25)]
        }
    }
    
    categories = ["Noob", "Beginner", "Intermediate", "Advanced", "Elite", "Freak"]
    
    # Convert kg to lbs if necessary
    if unit == 'lb':
        bw /= 2.20462
        squat /= 2.20462
        bench /= 2.20462
        deadlift /= 2.20462

    # Function to determine the category of a lift
    def determine_category(lift, standards, bw):
        lift_ratio = lift / bw
        print(f"Lift: {lift}, Bodyweight: {bw}, Lift Ratio: {lift_ratio}")
        for i, (low, high) in enumerate(standards):
            print(f"Range {i}: {low} - {high}")
            if low <= lift_ratio < high:
                print(f"Category: {categories[i]}")
                return categories[i]
        print(f"Category: {categories[-1]}")
        return categories[-1]
    
    # Get the appropriate standards based on gender
    gender_standards = standards[gender.lower()]
    # Determine categories for each lift
    squat_category = determine_category(squat, gender_standards["squat"], bw)
    bench_category = determine_category(bench, gender_standards["bench"], bw)
    deadlift_category = determine_category(deadlift, gender_standards["deadlift"], bw)
    
    return squat_category, bench_category, deadlift_category
