/*
 The Patchy Processing library, which provides an easy-to-use
 bicubic patch object for 3D graphics.

 Copyright 2008 Jonathan Feinberg

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
package patchy;

import java.text.DecimalFormat;

import processing.core.PVector;

/**
 * Immutable
 * @author jdf
 *
 */
public class BoundingVolume
{
	/**
	 * Immutable
	 * @author jdf
	 */
	public static class Range
	{
		public final double min;
		public final double max;

		Range()
		{
			min = Double.MAX_VALUE;
			max = -Double.MAX_VALUE;
		}

		private Range(final double min, final double max)
		{
			this.min = min;
			this.max = max;
		}

		Range with(final double value)
		{
			return new Range(value < min ? value : min, value > max ? value : max);
		}

		Range scaled(final double scale)
		{
			return new Range(min * scale, max * scale);
		}

		public float center()
		{
			return (float) (min + ((max - min) / 2.0));
		}

		public float length()
		{
			return (float) (max - min);
		}

		public float minimum()
		{
			return (float) min;
		}

		public float maximum()
		{
			return (float) max;
		}

		private static final DecimalFormat F = new DecimalFormat("0.0");

		@Override
		public String toString()
		{
			return "[" + F.format(min) + "," + F.format(max) + "]";
		}
	}

	public final Range x, y, z;

	public BoundingVolume()
	{
		this(new Range(), new Range(), new Range());
	}

	private BoundingVolume(final Range x, final Range y, final Range z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public BoundingVolume with(final BoundingVolume v)
	{
		return with(v.x.min, v.y.min, v.z.min).with(v.x.max, v.y.max, v.z.max);
	}

	BoundingVolume with(final PVector v)
	{
		return with(v.x, v.y, v.z);
	}

	BoundingVolume with(final double xv, final double yv, final double zv)
	{
		return new BoundingVolume(x.with(xv), y.with(yv), z.with(zv));
	}

	public BoundingVolume scaled(final double scale)
	{
		return new BoundingVolume(x.scaled(scale), y.scaled(scale), z.scaled(scale));
	}

	public float maxDimension()
	{
		double max = x.length();
		max = Math.max(max, y.length());
		max = Math.max(max, z.length());
		return (float) max;
	}

	public PVector center()
	{
		return new PVector(x.center(), y.center(), z.center());
	}

	public float boundingSphereRadius()
	{
		final double m = maxDimension();
		return (float) Math.sqrt(2 * m * m);
	}

	@Override
	public String toString()
	{
		return "x:" + x + ", y:" + y + ", z:" + z;
	}
}
