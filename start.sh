# 1. Get signed database snapshot URL (assuming you use get-chainweb-image-url.js form above)
npm install aws-sdk
YOUR_DB_SNAPSHOT_URL=$(node index.js)

# 2. Initialize a database that is persisted on a docker volume
docker run -ti --rm \
    --mount type=volume,source=chainweb-data,target=/data \
    --env DBURL=$YOUR_DB_SNAPSHOT_URL \
    kadena/chainweb-node \
    /chainweb/initialize-db.sh

# 3. Use the database volume with a Chainweb node
docker run \
    --detach \
    --publish 1848:1848 \
    --publish 1789:1789 \
    --name chainweb-node \
    --mount type=volume,source=chainweb-data,target=/data \
    kadena/chainweb-node