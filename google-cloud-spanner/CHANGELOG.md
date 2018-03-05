# Release History

### 1.3.1 / 2018-02-27

* Add Batch Client
  * Support partitioned reads and queries.
* Support Shared Configuration.
* Fix issue with IAM Policy not refreshing properly.
* Fix issue when using Time objects as keys.

### 1.2.0 / 2017-12-19

* Update Low Level API code
  * Remove deprecated constructor arguments.
  * Update documentation.
* Update google-gax dependency to 1.0.

### 1.1.1 / 2017-11-15

* Fix Admin Credentials (GAPIC) environment variable names.

### 1.1.0 / 2017-11-14

* Add `Google::Cloud::Spanner::Credentials` class.
* Rename constructor arguments to `project_id` and `credentials`.
  (The previous arguments `project` and `keyfile` are still supported.)
* Document `Google::Auth::Credentials` as `credentials` value.
* Update generated low level GAPIC code.
* Updated `google-gax` (`grpc`, `google-protobuf`), `googleauth` dependencies.

### 1.0.0 / 2017-09-29

* Release 1.0

### 0.23.2 / 2017-09-12

* Update connection configuration.

### 0.23.1 / 2017-08-18

* Update connection configuration.

### 0.23.0 / 2017-07-27

* Add `Job#error` returning `Spanner::Status`.

### 0.22.0 / 2017-07-11

* Remove `Policy#deep_dup`.
* Add thread pool size to `Session` pool configuration.
* Add error handling for some GRPC errors.
* Do not allow nested snapshots or transactions.
* Update initialization to raise a better error if project ID is not specified.
* Update GAPIC configuration to exclude `UNAVAILABLE` errors from automatic retry.
* Update example code in the API documentation and guide.

### 0.21.0 / 2017-06-08

Initial implementation of the Google Cloud Spanner API Ruby client.
