#include "gatekeeper.h"

#include "err/errors.h"

#include "mappers.h"

namespace service {
grpc::ServerUnaryReactor *Gatekeeper::CheckRbac(
	grpc::CallbackServerContext *context, const gk::v1::CheckRbacRequest *request,
	gk::v1::CheckRbacResponse *response) {
	auto *reactor = context->DefaultReactor();

	if (request->has_identity_sub()) {
		// TODO: implement checking access by sub
		reactor->Finish(grpc::Status(grpc::StatusCode::UNIMPLEMENTED, "Not implemented"));
		return reactor;
	}

	try {
		const auto policies =
			datastore::RbacPolicy::Cache::check(request->identity_id(), request->permission());
		map(policies, response);
	} catch (...) {
		reactor->Finish(grpc::Status(grpc::StatusCode::UNAVAILABLE, "Failed to check rbac"));
		return reactor;
	}

	reactor->Finish(grpc::Status::OK);
	return reactor;
}
} // namespace service
