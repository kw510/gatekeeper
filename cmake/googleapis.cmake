# libgoogleapis
cmake_path(SET googleapis_annotations_proto ${googleapis_SOURCE_DIR}/google/api/annotations.proto)
cmake_path(SET googleapis_annotations_header ${CMAKE_CURRENT_BINARY_DIR}/google/api/annotations.pb.h)
cmake_path(SET googleapis_annotations_source ${CMAKE_CURRENT_BINARY_DIR}/google/api/annotations.pb.cc)

cmake_path(SET googleapis_http_proto ${googleapis_SOURCE_DIR}/google/api/http.proto)
cmake_path(SET googleapis_http_header ${CMAKE_CURRENT_BINARY_DIR}/google/api/http.pb.h)
cmake_path(SET googleapis_http_source ${CMAKE_CURRENT_BINARY_DIR}/google/api/http.pb.cc)

set(googleapis_protos
	${googleapis_annotations_proto}
	${googleapis_http_proto}
)

set(googleapis_headers
	${googleapis_annotations_header}
	${googleapis_http_header}
)

set(googleapis_sources
	${googleapis_annotations_source}
	${googleapis_http_source}
)

add_custom_command(
	OUTPUT ${googleapis_headers} ${googleapis_sources}
	DEPENDS ${googleapis_protos}
	COMMAND $<TARGET_FILE:protoc>
	ARGS
		--proto_path=${googleapis_SOURCE_DIR}
		--proto_path=${protobuf_include_dir}
		--cpp_out=${CMAKE_CURRENT_BINARY_DIR}
		${googleapis_protos}
)

add_library(googleapis
	${googleapis_sources}
)

target_include_directories(googleapis
	PUBLIC ${CMAKE_CURRENT_BINARY_DIR}
	PRIVATE ${protobuf_include_dir}
)
