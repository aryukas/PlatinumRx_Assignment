# 01_Time_Converter.py

def convert_minutes(total_minutes):
    hours = total_minutes // 60
    minutes = total_minutes % 60

    # Formatting in readable string
    if hours > 1:
        return f"{hours} hrs {minutes} minutes"
    elif hours == 1:
        return f"1 hr {minutes} minutes"
    else:
        return f"{minutes} minutes"


# Example usage:
if __name__ == "__main__":
    minutes = int(input("Enter minutes: "))
    result = convert_minutes(minutes)
    print(result)
