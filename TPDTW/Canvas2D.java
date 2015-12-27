import java.awt.Canvas;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.ArrayList;
import java.util.Vector;

import lx.interaction.dollar.*;
import lx.interaction.touch.*;

/**
 * Canvas2D.java
 *
 * @author <a href="mailto:gery.casiez@lifl.fr">Gery Casiez</a>
 * @version
 */


public class Canvas2D extends Canvas implements MouseMotionListener, MouseListener, DollarListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// Stroke of reference
	private Vector<Point> RStroke;
	
	// Stroke to test
	private Vector<Point> TStroke;
	
	private int shiftModifier = 17;
	
	Dollar dollar = new Dollar(Dollar.GESTURES_DEFAULT);
	String name = "";
	double score = 0;
	boolean ok = false;
	int state;

	
	Canvas2D () {
		RStroke = new Vector<Point>();
		TStroke = new Vector<Point>();
		
		addMouseListener(this);
		addMouseMotionListener(this);
		
		dollar.setListener(this);
		dollar.setActive(true);
		
		setBackground(new Color(255,255,255));
	}
	
	
	public void paint (Graphics g){ 
		g.drawString("Drag avec le bouton gauche ou droit de la souris + Shift : cr�ation d'une courbe de r�f�rence",10,15); 
		g.drawString("Drag avec le bouton gauche ou droit de la souris : cr�ation d'une courbe de test",10,30); 
		if (ok)
			g.drawString("gesture: " + name + " (" + score + ")", 10, 60);	
		int r = 5;  
		
		if (!RStroke.isEmpty()) {
			g.setColor(Color.black);
			for (int i = 1; i < RStroke.size(); i++) {
				g.drawLine(RStroke.elementAt(i-1).x, RStroke.elementAt(i-1).y,
						RStroke.elementAt(i).x, RStroke.elementAt(i).y);		
				g.drawArc(RStroke.elementAt(i-1).x - r, RStroke.elementAt(i-1).y - r, 2*r, 2*r, 0, 360);
			}
			g.drawArc(RStroke.elementAt(RStroke.size()-1).x - r, RStroke.elementAt(RStroke.size()-1).y - r, 2*r, 2*r, 0, 360);
		}
 
		if (!TStroke.isEmpty()) {
			g.setColor(Color.orange);
			for (int i = 1; i < TStroke.size(); i++) {
				g.drawLine(TStroke.elementAt(i-1).x, TStroke.elementAt(i-1).y,
						TStroke.elementAt(i).x, TStroke.elementAt(i).y);
				g.drawArc(TStroke.elementAt(i-1).x - r, TStroke.elementAt(i-1).y - r, 2*r, 2*r, 0, 360);
			}
			g.drawArc(TStroke.elementAt(TStroke.size()-1).x - r, TStroke.elementAt(TStroke.size()-1).y - r, 2*r, 2*r, 0, 360);
		}
		
		if(RStroke.size() > 1 && TStroke.size() > 1) {
			final DTW dtw = new DTW(RStroke, TStroke);
			final Matrix m = dtw.calcM();
			g.setColor(Color.magenta);
			
			if(m == null) {
				System.out.println("Erreur dans le calcul de la matrice");
				return;
			}
			
			Couple c = m.couple[dtw.n-1][dtw.m-1];
			boolean beginForm = false;
			
			while(c.x > 0 && c.y > 0) {
				
				final Point pT = TStroke.elementAt(c.y);
				final Point pR = RStroke.elementAt(c.x);
				
				Couple cNext = m.couple[c.x][c.y];
				
				if(pT == null || pR == null)
					break;
				
				if(TStroke.elementAt(cNext.y) != pT && RStroke.elementAt(cNext.x) != pR)
					beginForm = true;
				
				if(beginForm)
					g.drawLine(pT.x, pT.y, pR.x, pR.y);
				
				c = m.couple[c.x][c.y];
			}
		}
				
	}

	public void mouseMoved(MouseEvent e) {
		state = 0;
	}

	public void mouseDragged(MouseEvent e) {
		if ((e.getModifiers() == shiftModifier) || RStroke.isEmpty())
			RStroke.add(e.getPoint());
		else
			TStroke.add(e.getPoint());
		
		state = 2;
		dollar.pointerDragged(e.getX(), e.getY());
		repaint();
	}	
	
	public void mouseClicked(MouseEvent e) {
		
	}

	public void mouseEntered(MouseEvent e) {
		
	}

	public void mouseExited(MouseEvent e) {
		
	}

	public void mousePressed(MouseEvent e) {
		if ((e.getModifiers() == shiftModifier) || RStroke.isEmpty())
			RStroke.clear();
		else
			TStroke.clear();
		
		state = 1;
		dollar.pointerPressed(e.getX(), e.getY());
	}

	public void mouseReleased(MouseEvent e) {
		state = 0;
		dollar.pointerReleased(e.getX(), e.getY());		
	}


	@Override
	public void dollarDetected(Dollar dollar) {
		score = dollar.getScore();
		name = dollar.getName();
		
		ok = score > 0.80;
		repaint();
		
	}  
}
