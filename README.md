This is sample of build HTTP server with https://github.com/swhitty/FlyingFox library with React.

Project Setup:
1. Test on Xcode Version 15.3, default Swift app
2. After creating project, need to enable Incoming and Outgoing connect in Signing And Cababilities setting (App SandBox)
3. Neet to include FlyingFox in app dependencies

To run react app with FlyingFox, we need to publish react app with webpack. Webpack will compile and generate resources which we can browse as html and js app.
React Project Setup:

1. Publish your ReactApp with webpack. I use this webpack setting of default React app

```
var path    = require('path');
var hwp     = require('html-webpack-plugin');

module.exports = {
    entry: path.join(__dirname, '/src/index.js'),
    output: {
        filename: 'build.js',
        path: path.join(__dirname, 'dist')
    },
    module:{
        rules:[{
            exclude: /node_modules/,
            test: /\.js$/,
            loader: 'babel-loader'
        }]
    },
    plugins:[
        new hwp({template:path.join(__dirname, '/src/index.html')})
    ]
} ```

2. In package.json File, I have build config like this `react-scripts build`. After running `npm run build`, we have build folder.

Now we are ready to serve index.html

### Including published react resources into Swift ##

I just simply copied all the resources into bundle

![image](https://github.com/DreamRunnerMoshi/FlyingFoxReactApp/assets/4157158/646af999-1d13-4d7b-86eb-3307c4d80a17)


