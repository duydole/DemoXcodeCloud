#!/bin/sh

# Dừng script nếu có lỗi
set -e

# Kiểm tra xem Slather đã được cài chưa, nếu chưa thì cài qua Homebrew
if ! command -v slather &> /dev/null; then
    echo "Cài đặt Slather..."
    brew install slather
fi

# Chạy Slather để tạo báo cáo test coverage
echo "Tạo báo cáo test coverage với Slather..."
slather coverage --sonarqube-xml

# Di chuyển báo cáo vào thư mục artifact (nếu cần tải lên)
# echo "Sao chép báo cáo vào thư mục artifact..."
# mkdir -p $CI_DERIVED_DATA_PATH/artifacts
# cp -r ./coverage-report $CI_DERIVED_DATA_PATH/artifacts/

# Thoát với mã 0 nếu thành công
echo "Hoàn tất tạo báo cáo test coverage."
exit 0