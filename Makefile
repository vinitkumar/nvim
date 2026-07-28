.PHONY: test

test:
	@test_tmp_dir="$$(mktemp -d)"; \
	trap 'rm -rf "$$test_tmp_dir"' EXIT; \
	NVIM_LOG_FILE="$$test_tmp_dir/nvim.log" \
	XDG_CACHE_HOME="$$test_tmp_dir/cache" \
	XDG_STATE_HOME="$$test_tmp_dir/state" \
	nvim --headless -i NONE -u NONE -l tests/bright_colorscheme_spec.lua && \
	NVIM_LOG_FILE="$$test_tmp_dir/nvim.log" \
	XDG_CACHE_HOME="$$test_tmp_dir/cache" \
	XDG_STATE_HOME="$$test_tmp_dir/state" \
	nvim --headless -u init.lua -l tests/startup_spec.lua && \
	NVIM_LOG_FILE="$$test_tmp_dir/nvim.log" \
	XDG_CACHE_HOME="$$test_tmp_dir/cache" \
	XDG_STATE_HOME="$$test_tmp_dir/state" \
	nvim --headless -u init.lua -l tests/ocaml_lsp_spec.lua
