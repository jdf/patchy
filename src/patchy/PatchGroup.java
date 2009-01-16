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

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.GZIPInputStream;

import patchy.readers.BPTReader;
import processing.core.PApplet;
import processing.core.PImage;

public class PatchGroup implements Patchy
{
	final List<Patchy> patches = new ArrayList<Patchy>();
	BoundingVolume bounds = null;

	public PatchGroup()
	{
	}

	public void add(final Patchy patch)
	{
		patches.add(patch);
	}

	public void draw(final PApplet p, final PImage texture)
	{
		for (final Patchy patch : patches)
			patch.draw(p, texture);
	}

	public void draw(final PApplet p)
	{
		for (final Patchy patch : patches)
			patch.draw(p);
	}

	public BoundingVolume getBounds()
	{
		if (bounds == null)
		{
			bounds = new BoundingVolume();
			for (final Patchy patch : patches)
				bounds = bounds.with(patch.getBounds());
		}
		return bounds;
	}

	public void setBasis(final double[][] basis)
	{
		for (final Patchy patch : patches)
			patch.setBasis(basis);
		bounds = null;
	}

	public void setGridSteps(final int gridSteps)
	{
		for (final Patchy patch : patches)
			patch.setGridSteps(gridSteps);
		bounds = null;
	}

	public BoundingVolume scale(final double scale)
	{
		for (final Patchy patch : patches)
			patch.scale(scale);
		bounds = null;
		return getBounds();
	}

	public void translate(final double dx, final double dy, final double dz)
	{
		for (final Patchy patch : patches)
			patch.translate(dx, dy, dz);
		bounds = null;
	}

	public static Patchy teacup()
	{
		return loadBptResource("teacup");
	}

	public static Patchy teapot()
	{
		return loadBptResource("teapot");
	}

	private static Patchy loadBptResource(final String bpt)
	{
		try
		{
			return BPTReader.read(new GZIPInputStream(Patch.class.getResourceAsStream(bpt
					+ ".bpt.gz")));
		}
		catch (IOException e)
		{
			throw new RuntimeException(e);
		}
	}

}
