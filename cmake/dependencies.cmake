include(FetchContent)

# grpc & protobuf
message(STATUS "Fetching gRPC and dependencies (this can take a while)")
FetchContent_Declare(grpc
	GIT_REPOSITORY https://github.com/grpc/grpc
	GIT_TAG        v1.47.5
)
FetchContent_MakeAvailable(grpc)
message(STATUS "Fetching gRPC and dependencies - done")

get_target_property(protobuf_include_dir protobuf::libprotoc INTERFACE_INCLUDE_DIRECTORIES)

# googleapis
FetchContent_Declare(googleapis
	URL      https://github.com/googleapis/googleapis/archive/5d2c0c55cf16534d97eb3405840126113ba1ebbd.tar.gz
	URL_HASH SHA256=8111518a0acd858cc279a82641d623a0e7c1bc4ae69721688260b95ed27b6fff
)
FetchContent_MakeAvailable(googleapis)

# libviper
FetchContent_Declare(libviper
	URL      https://github.com/uditha-atukorala/libviper/archive/refs/tags/v0.3.1.tar.gz
	URL_HASH SHA256=24a79fe54708a315394938f7946dab35aa69b884f0fab4ac0a9fa42b60c93313
)
FetchContent_MakeAvailable(libviper)
