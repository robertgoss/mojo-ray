# Based on https://raytracing.github.io
from vec3 import Vec3, Point3, unit_vector
from colour import Colour, write_colour
from ray import Ray

fn write_ppm_header(inout file : FileHandle, width : Int16, height : Int16) raises:
    file.write(StringRef("P3\n"))
    file.write(str(width))
    file.write(StringRef(" "))
    file.write(str(height))
    file.write(StringRef("\n255\n"))

fn to_float(int : Int16) -> Float64:
    return int.cast[DType.float64]()

fn ray_colour(ray : Ray) -> Colour:
    var unit_direction = unit_vector(ray.direction)
    var a = 0.5*(unit_direction.y + 1.0)
    return (1.0-a)*Colour(1.0, 1.0, 1.0) + a*Colour(0.5, 0.7, 1.0)

fn main() raises:
    # Get image size
    var image_width : Int16 = 400
    var aspect_ratio : Float64 = 16.0 / 9.0
    var image_height : Int16 = max(1, int(to_float(image_width) / aspect_ratio))

    # Camera size
    var focal_length = 1.0
    var viewport_height : Float64 = 2.0
    var viewport_width : Float64 =
     viewport_height * (to_float(image_width) / to_float(image_height))
    var camera_origin = Point3(0,0,0)
    # Make the viewport frame
    var viewport_u = Vec3(viewport_width, 0, 0)
    var viewport_v = Vec3(0, -viewport_height, 0)
    # Size of pixels
    var pixel_delta_u = viewport_u / to_float(image_width)
    var pixel_delta_v = viewport_v / to_float(image_height)

    # Calculate the location of the upper left pixel.
    var viewport_upper_left = camera_origin
                             - Vec3(0, 0, focal_length) - viewport_u/2 - viewport_v/2
    var pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v)

    with open("image.ppm", "w") as image:
        write_ppm_header(image, image_width, image_height)
        for j in range(image_height):
            print("\rScanlines remaining: ", image_height-j)
            for i in range(image_width):
                var pixel_center = pixel00_loc + (to_float(i) * pixel_delta_u) + (to_float(j) * pixel_delta_v)
                var ray_direction = pixel_center - camera_origin
                var ray = Ray(camera_origin, ray_direction)
                var colour = ray_colour(ray)
                write_colour(image, colour)
                    
    print("\rDone                                       ")