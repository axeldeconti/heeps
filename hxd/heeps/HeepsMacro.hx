package hxd.heeps;

class HeepsMacro
{
  
  #if macro
  
  // Add with --macro hxd.heeps.HeepsMacro.init()
  public static function init()
  {
    haxe.macro.Compiler.define("heeps_macro", "1");
    var fixups:Array<String> = new Array();
    for (k in hxd.res.Config.extensions.keys())
    {
      if (k.indexOf("gif") != -1)
      {
        fixups.push(k);
      }
    }
    for (f in fixups)
    {
      var v = hxd.res.Config.extensions.get(f);
      hxd.res.Config.extensions.remove(f);
      if (f == "gif") continue;
      var k =
      if (StringTools.endsWith(f, ",gif")) f.substr(0, f.length - 4);
      else StringTools.replace(f, "gif,", ",");
      hxd.res.Config.extensions.set(k, v);
    }
    hxd.res.Config.extensions.set("giff,gif", "hxd.res.GifImage");
    // hxd.res.Config.pairedExtensions.set("giff", "png,gif");
    hxd.res.Config.pairedExtensions.set("gif", "png");
    
    // So compiler would resolve this.
    var c = new hxd.heeps.GifConvert();
    
    hxd.fs.Convert.converts.push("hxd.heeps.GifConvert");
    if (haxe.macro.Context.definedValue("format-tiled") >= "2.0.0")
    {
      hxd.res.Config.extensions.set("tmx", "hxd.res.TmxMap");
    }
  }
  
  #end
  
}