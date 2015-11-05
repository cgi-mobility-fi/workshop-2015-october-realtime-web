# Realtime Web Workshop
On the server side, we are polling for locations of all the busses in the tampere city and saving this data to a server-side backbone collection.
On the client side, we are populating a map with locations of all the busses, which are taken from the client-side backbone collection.  
We are using WebSockets, more specifically Socket.io, to synchronize the server-side and client-side bus location collections.

## Getting it up and running
1. Install Node.js (v0.12.7 was used in the workshop)
2. Check that NPM is installed:  
  `npm --version`  
  Usually NPM comes with node, but there are some linux distors which require you to install NPM separately.  
  If NPM was not installed, install NPM.
3. Install grunt-cli as a global package:  
  `npm install -g grunt-cli`
4. Install server-side dependencies:  
  Make sure you are in the `server` directory.  
  `npm install`
5. Run server-side tests:  
  Make sure you are in the `server` directory.  
  `npm test`
6. Start the server-side project:  
  Make sure you are in the `server` directory.  
  `npm start`
7. Install client-side dependencies: 
  Make sure you are in the `client` directory.  
  `npm install`
8. There are different ways you can build the client side project
  * Build a version which does't have the source files minified (great for debugging):  
  `grunt`  
  * Build a release version which minifies the source files (a cordova project could also create Android, iOS or WindowsPhone packages as well):  
  `grunt release`  
  * Build a debuggable version, serve it in a temporary http-server on port 8080 and start waiting for changes in the source files. When you change the source files, the client is automatically rebuilt and (using websockets) the browser is notified and will refresh for you:  
  `grunt dev`

## Server project status
- [x] HTTP and Socket.io running on port 3000
- [x] Vehicle model
- [x] Vehicle collection which polls an external service
- [x] WebSocket service 'siri', which notifies all connected clients of vehicle collection changes
- [ ] All tests passing

## Client project status
- [x] Map of the world
- [x] Vehicle model
- [x] Vehicle collection, synced with the 'siri' WebSocket updates
- [x] Displays vehicle location on the map
- [ ] Update vehicle locations on the map when the server has new data
