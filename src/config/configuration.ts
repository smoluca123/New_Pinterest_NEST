export default () => ({
  port: parseInt(process.env.PORT || '0', 10) || 8080,
});
