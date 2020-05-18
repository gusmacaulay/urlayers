//Credit to blog here ...https://dominoc925.blogspot.com/2019/10/simple-example-of-reactjs-and.html
import React from 'react'

// Start Openlayers imports
import {
    Map,
    View
 } from 'ol'
import {
    GeoJSON,
    XYZ
} from 'ol/format'
import {
    Tile as TileLayer,
    Vector as VectorLayer
} from 'ol/layer'
import {
    Vector as VectorSource,
    OSM as OSMSource,
    XYZ as XYZSource,
    TileWMS as TileWMSSource
} from 'ol/source'
import {
    Select as SelectInteraction,
    defaults as DefaultInteractions
} from 'ol/interaction'
import {
    Attribution,
    ScaleLine,
    ZoomSlider,
    Zoom,
    Rotate,
    MousePosition,
    OverviewMap,
    defaults as DefaultControls,
} from 'ol/control'
import {defaults as defaultInteractions, DragRotateAndZoom} from 'ol/interaction';
import {
    Style,
    Fill,
    RegularShape as RegularShape,
    Stroke as Stroke,
    Circle as CircleStyle
} from 'ol/style'

import {
    Projection,
    get as getProjection
 } from 'ol/proj'
 import Polygon from 'ol/geom/Polygon';
 //import Draw, {createRegularPolygon, createBox} from 'ol/interaction/Draw';
 import {Draw, Modify, Snap} from 'ol/interaction';
//import 'ol/ol.css'
// End Openlayers imports

class OLMapFragment extends React.Component {
    constructor(props) {
        super(props)
        this.updateDimensions = this.updateDimensions.bind(this)
    }
    updateDimensions(){
        const h = window.innerWidth >= 992 ? (window.innerHeight - 250) : 400
        this.setState({height: h})
    }
    componentWillMount(){
        window.addEventListener('resize', this.updateDimensions)
        this.updateDimensions()
    }
    componentDidMount(){
        // Openlayer Map instance with openstreetmap base and vector edit layer

        var source = new VectorSource();
        var vector = new VectorLayer({
          source: source,
          style: new Style({
            fill: new Fill({
              color: 'rgba(255, 255, 255, 0.2)'
            }),
            stroke: new Stroke({
              color: '#ffcc33',
              width: 2
            }),
            image: new CircleStyle({
              radius: 7,
              fill: new Fill({
                color: '#ffcc33'
              })
            })
          })
        });
        const drawMcdrawFace =  new Draw({
           source: source,
           type: 'Polygon',
         });
         drawMcdrawFace.on('drawend', function (event) {
          var feature = event.feature;
          var features = vector.getSource().getFeatures();
          features = features.concat(feature);
          features.forEach(function() {
          var format = new GeoJSON();
          var routeFeatures = format.writeFeatures(features);
          //alert(routeFeatures);
          api.action('urhack','json',routeFeatures);
            });
          });

        const map = new Map({
            //  Display the map in the div with the id of map
            target: 'map',
            layers: [
                new TileLayer({
                    source: new XYZSource({
                        url: 'https://{a-c}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        projection: 'EPSG:3857'
                    })
                }),
                vector,
            ],
            // Add in the following map controls
            controls: DefaultControls().extend([
                new ZoomSlider(),
                new MousePosition(),
                new ScaleLine(),
                new OverviewMap(),
                //new DefaultControls()
            ]),
             interactions: defaultInteractions().extend([
               new DragRotateAndZoom(),
               drawMcdrawFace,
               new Modify({source: source}),
               new Snap({source: source}),
            ]),
            // Render the tile layers in a map view with a Mercator projection
            view: new View({
                projection: 'EPSG:3857',
                center: [0, 0],
                zoom: 2
            })
        })
    //    var allFeatures = source.getFeatures();
    //    var format = new GeoJSON();
//      var routeFeatures = format.writeFeatures(allFeatures);
    }
    componentWillUnmount(){
        window.removeEventListener('resize', this.updateDimensions)
    }
    render(){
        const style = {
            width: '100%',
            height:this.state.height,
            backgroundColor: '#cccccc',
        }
        return (
                    <div id='map' style={style} >
                    </div>
        )
    }
}
export default OLMapFragment
