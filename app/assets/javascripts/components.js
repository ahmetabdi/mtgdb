// Manually add components to window and global
// so that react_ujs and react-server can find them and render them.
window.SearchKit = global.SearchKit = require("./components/searchkit.js.jsx").default
