module.exports = {
  purge: [
    "../lib/**/*.eex",
    "../lib/**/*.leex",
    "../lib/**/*_view.ex",
    "../lib/**/components/**/*.ex",
    "../lib/**/views/*.ex"
  ],
  mode: 'jit',
  theme: {},
  variants: {},
  plugins: []
}
