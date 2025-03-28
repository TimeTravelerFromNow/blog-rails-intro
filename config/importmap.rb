# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# in my personal apps, Im removing bootstrap javascript, as popper doesnt fully work with v5
# you can still use bootstrap CSS which is available from the gem, remove js imports of bootstrap.
# then refactor all the bootstrap JS elements in your views to use web components or floating-ui
pin "bootstrap" # @5.3.2
# another issue of using bootstrap js, precompiling popper dependency will fail.
# popperjs needs to pinned to a bundled version of popper to support rails assets:precompile
# this is a temporary fix for the purposes of supporting this tutorial app
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js"

pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "@floating-ui/core", to: "@floating-ui--core.js" # @1.6.5
pin "@floating-ui/utils", to: "@floating-ui--utils.js" # @0.2.5
pin "@floating-ui/dom", to: "@floating-ui--dom.js" # @1.6.8
pin "@floating-ui/utils/dom", to: "@floating-ui--utils--dom.js" # @0.2.5
