import mbs.io.MbsReader; // git checkout 0.1
import com.stencyl.io.mbs.scene.MbsScene;
import com.stencyl.io.mbs.Typedefs; // git checkout b01c152bd04666f2da6a26f04e989b50446dbd7c
import mbs.io.MbsList;
import com.stencyl.io.mbs.scene.MbsActorInstance;
import com.stencyl.io.mbs.shape.MbsWireframe;
import com.stencyl.io.mbs.shape.MbsPoint;

//import com.stencyl.io.ShapeReader;

class Main {
  static function main() {
    var reader:MbsReader = new MbsReader(Typedefs.get(), false, true);
    var bytes = sys.io.File.getBytes("./scene-13.mbs");
    reader.readData(bytes);

    var scene:MbsScene = cast reader.getRoot();

    var numTileLayers = scene.getDepth();
    var sceneWidth = scene.getWidth();
    var sceneHeight = scene.getHeight();
    var tileWidth = scene.getTileWidth();
    var tileHeight = scene.getTileHeight();
    var gravityX = scene.getGravityX();
    var gravityY = scene.getGravityY();
    var eventSnippetID = scene.getEventSnippetID();
    
    trace("width", sceneWidth / tileWidth);
    trace("layers", numTileLayers);

    var joints = scene.getJoints();
    var regions = scene.getRegions();
    var terrainRegions = scene.getTerrainRegions();
    trace("joints", joints.length());
    trace("regions", regions.length());
    trace("terrainRegions", terrainRegions.length());
    
    var actors:MbsList<MbsActorInstance> = scene.getActorInstances();
    trace("actors", actors.length());
    for(i in 0...actors.length()) {
      var actor:MbsActorInstance = actors.getNextObject();
      var elementID = actor.getAid();
      var x = actor.getX();
      var y = actor.getY();
      var scaleX = actor.getScaleX();
      var scaleY = actor.getScaleY();
      var layerID = actor.getZ();
      var orderInLayer = actor.getOrderInLayer();
      var angle = Std.int(actor.getAngle());
      var groupID = actor.getGroupID();
      var actorID = actor.getId();
      var isCustomized = actor.getCustomized();
      trace(x, y, actorID);
    }

    var wireframes:MbsList<MbsWireframe> = scene.getTerrain();
    trace("wireframes", wireframes.length());
    for(i in 0...wireframes.length()) {
      var poly = wireframes.getNextObject();
      var position:MbsPoint = poly.getPosition();
      var posx = position.getX();
      var posy = position.getY();
      var points:MbsList<MbsPoint> = poly.getPoints();
      // var shapeData:Map<Int,Dynamic> = ShapeReader.createPolygon("MbsWireframe", points);
      trace(posx, posy, points.length(), ':');//, position, points, shapeData);
      for (j in 0...points.length()) {
        var p = points.getNextObject();
        var px = p.getX();
        var py = p.getY();
        trace("  ", px, py);
      }
    }
  }
}
