import { mergeProps, useSSRContext } from 'vue';
import { ssrRenderAttrs } from 'vue/server-renderer';
import { _ as _export_sfc } from './server.mjs';
import '../nitro/nitro.mjs';
import 'node:http';
import 'node:https';
import 'node:events';
import 'node:buffer';
import 'node:fs';
import 'node:path';
import 'node:crypto';
import 'node:url';
import 'vue-router';

const _sfc_main = {};
function _sfc_ssrRender(_ctx, _push, _parent, _attrs) {
  _push(`<div${ssrRenderAttrs(mergeProps({ class: "container" }, _attrs))} data-v-518669a0><header data-v-518669a0><h1 data-v-518669a0>easy_terraform_aws</h1></header><main data-v-518669a0><div class="success-card" data-v-518669a0><h2 data-v-518669a0>It&#39;s alive! It&#39;s alive!</h2><small data-v-518669a0>Dr. Frankenstein, &quot;Frankenstein&quot;(1931)</small><p data-v-518669a0>Este projeto Nuxt foi implantado com sucesso usando Terraform, Docker e Nginx.</p><div class="status" data-v-518669a0><span class="dot" data-v-518669a0></span><span data-v-518669a0>Tudo funcionando perfeitamente</span></div></div></main><footer data-v-518669a0><p data-v-518669a0>github.com/everton-tenorio</p></footer></div>`);
}
const _sfc_setup = _sfc_main.setup;
_sfc_main.setup = (props, ctx) => {
  const ssrContext = useSSRContext();
  (ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("pages/index.vue");
  return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
const index = /* @__PURE__ */ _export_sfc(_sfc_main, [["ssrRender", _sfc_ssrRender], ["__scopeId", "data-v-518669a0"]]);

export { index as default };
//# sourceMappingURL=index.vue.mjs.map
