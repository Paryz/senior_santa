module.exports = {
  purge: [
    "./js/**/*.js", 
    "../lib/**/*.eex",
    "../lib/**/*.leex",
    "../lib/**/*_view.ex",
    "../lib/**/components/**/*.ex",
    "../lib/**/views/*.ex"
  ],
  mode: 'jit',
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: []
}
