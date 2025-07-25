export CV_BACKEND_DB_HOST=localhost:54321
export CV_BACKEND_DB_NAME=platform
export CV_BACKEND_DB_USER=platform
export CV_BACKEND_DB_PASS=password

export CV_BACKEND_MINIO_ENDPOINT=localhost:9000
export CV_BACKEND_MINIO_SERVER_URL=http://localhost:9000
export CV_BACKEND_MINIO_ACCESS_KEY=minioAccessKey
export CV_BACKEND_MINIO_SECRET_KEY=minioSecretKey
export CV_BACKEND_MINIO_BUCKET_NAME=minio-platform-docs

env | grep CV_BACKEND_ > .env
