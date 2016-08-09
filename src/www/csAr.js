var argscheck = require('cordova/argscheck'),
    exec      = require('cordova/exec');

function AR () {};

AR.prototype = {

    canDoAr: function (success, failure)
    {
        argscheck.checkArgs('fF', 'CsAR.canDoAR', arguments);
        exec(success, failure, 'CsAR', 'canDoAR', []);
    },

    showGeolocationsForSelection: function (params, success, failure)
    {
        argscheck.checkArgs('ofF', 'CsAR.showGeolocationsForSelection', arguments);

        // Perform all input validation here (native does not check) - - - - - -

        var maxDistance;
        var locs = [];

        if(params.maxDistance === undefined) maxDistance = 1000;
        else maxDistance = params.maxDistance;

        if(params.geoLocations === undefined) locs = [];
        params.geoLocations.forEach(function (loc) {
            if(typeof loc.latitude != "undefined" &&
               typeof loc.longitude != "undefined" &&
               typeof loc.image != "undefined" &&
               typeof loc.kind != "undefined" &&
               typeof loc.id != "undefined" 
            ) {
                locs.push(loc);
            }
        });

        console.log(locs);

        exec(success, failure, 'CsAR', 'showGeolocationsForSelection', [{
            maxDistance: maxDistance,
            geoLocations: locs,
        }]);
    },

};

module.exports = new AR;
