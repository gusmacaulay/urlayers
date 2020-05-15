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
    Fill as FillStyle,
    RegularShape as RegularShapeStyle,
    Stroke as StrokeStyle
} from 'ol/style'

import {
    Projection,
    get as getProjection
 } from 'ol/proj'
 import Polygon from 'ol/geom/Polygon';
 import Draw, {createRegularPolygon, createBox} from 'ol/interaction/Draw';
//import 'ol/ol.css'
// End Openlayers imports

class OLMapFragment extends React.Component {
    constructor(props) {
        super(props)
        this.updateDimensions = this.updateDimensions.bind(this)
    }
    updateDimensions(){
        const h = window.innerWidth >= 992 ? window.innerHeight : 400
        this.setState({height: h})
    }
    componentWillMount(){
        window.addEventListener('resize', this.updateDimensions)
        this.updateDimensions()
    }
    componentDidMount(){
        // Create an Openlayer Map instance with two tile layers
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
                new TileLayer({
                    source: new TileWMSSource({
                        url: 'https://ahocevar.com/geoserver/wms',
                        params: {
                            layers: 'topp:states',
                            'TILED': true,
                        },
                        projection: 'EPSG:4326'
                    }),
                    name: 'USA'
                }),
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
               new DragRotateAndZoom()
            ]),
            // Render the tile layers in a map view with a Mercator projection
            view: new View({
                projection: 'EPSG:3857',
                center: [0, 0],
                zoom: 2
            })
        })
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
