from vec3 import Vec3

fn write_colour(inout file : FileHandle, colour : Vec3) raises:    
    alias space = StringRef(" ")
    alias newline = StringRef("\n")
    var ir : UInt8 = int(255.999 * colour.x)
    var ig : UInt8 = int(255.999 * colour.y)
    var ib : UInt8 = int(255.999 * colour.z)
    file.write(str(ir))
    file.write(space)
    file.write(str(ig))
    file.write(space)
    file.write(str(ib))
    file.write(newline)