# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap" # @5.3.2
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "@floating-ui/core", to: "@floating-ui--core.js" # @1.6.5
pin "@floating-ui/utils", to: "@floating-ui--utils.js" # @0.2.5
pin "@floating-ui/dom", to: "@floating-ui--dom.js" # @1.6.8
pin "@floating-ui/utils/dom", to: "@floating-ui--utils--dom.js" # @0.2.5
