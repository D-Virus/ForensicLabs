**Verify the GCP Project**
```
gcloud config get-value project
```

**Verify the current date in Cloud Shell**
```
date
```

**Save the current date in a variable**
```
current_time=$(date)
echo $current_time
```

**Export the logs in Json**
```
gcloud logging read 'timestamp<="2023-06-02T06:00:00Z" AND timestamp>="2023-05-30T23:59:59Z"' --format="json" > "ForensicInvestigation_GCP_${current_time}.json"
```
