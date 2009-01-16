package patchy;

import processing.core.PApplet;
import processing.core.PImage;

public interface Patchy
{
	public static final double[][] BEZIER = Bicubic.BEZIER;
	public static final double[][] BSPLINE = Bicubic.BSPLINE;
	public static final double[][] CATMULL_ROM = Bicubic.CATMULL_ROM;
	public static final double[][] HERMITE = Bicubic.HERMITE;

	public BoundingVolume getBounds();

	/**
	 * <p>Set the basis matrix for this 
	 * @param basis
	 */
	public void setBasis(final double[][] basis);

	/**
	 * <p>Sets the "smoothness" of the rendered patch.
	 * <p>When generating the triangle mesh for this patch,
	 * use gridSteps X gridSteps vertices. Therefore,
	 * the cost of rendering this patch
	 * rises as the square of this parameter.
	 * <p>The default value is <code>20</code>. 
	 * @param gridSteps
	 */
	public void setGridSteps(final int gridSteps);

	public void draw(final PApplet p);

	public void draw(final PApplet p, final PImage texture);

	public BoundingVolume scale(final double scale);

	public void translate(final double dx, final double dy, final double dz);

}