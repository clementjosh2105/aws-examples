Import-Module AWS.Tools.S3

$region="ap-south-1"
$bucket_name= Read-Host -Prompt 'Enter S3 bucket name'

Write-Host "AWS Region: $region"
Write-Host "AWS Bucket: $bucket_name"

function BucketExists {
 $bucket_name = Get-S3Bucket -BucketName $bucket_name -ErrorAction SilentlyContinue
 return $null -ne $bucket_name
}

Write-Host "BucketName : $bucket_name"

if(-not (BucketExists)) {
    Write-Host "Bucket does not exists"
    New-S3Bucket -BucketName $bucket_name -Region $region
} else {
    Write-Host "Bucket already exists"
}

$my_file='myfile.txt'
$file_content='Hello world'

Set-Content -Path $my_file -Value $file_content

Write-S3Object -BucketName $bucket_name -File $my_file -Key $my_file -Region $region