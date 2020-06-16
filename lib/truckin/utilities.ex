defmodule Truckin.Utilities do
  alias Truckin.Utilities.Point

  @v :math.pi / 180
  @radius 6372.8

  def haversine_distance(p1 = %Point{}, p2 = %Point{}) do
    lat_diff = :math.sin((p1.latitude - p2.latitude )* @v / 2)
    lon_diff = :math.sin((p1.longitude - p2.longitude )* @v / 2)

    a = (lat_diff * lat_diff) + (lon_diff * lon_diff) * :math.cos(p1.latitude * @v) * :math.cos(p2.latitude * @v)
    @radius * 2 * :math.asin(:math.sqrt(a))
  end
end
