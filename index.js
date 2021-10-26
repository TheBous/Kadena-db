// get-chainweb-image-url.js
AWS = require("aws-sdk");
require('dotenv').config()

const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID, // Add your Access Key ID from IAM
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY, // Add your Secret Access Key from IAM
  region: "us-east-2"
})
const params = {
  Bucket: 'kadena-node-db',
  Expires: 3600,
  Key: 'db-chainweb-node-ubuntu.18.04-latest.tar.gz',
  RequestPayer: 'requester'
}
// When ran, the script will output exclusively the signed url
s3.getSignedUrl("getObject", params, (_err, res) => console.log(res))