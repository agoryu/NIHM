import java.awt.Point;
import java.util.Vector;


public class DTW {

	private Vector<Point> RStroke;
	private Vector<Point> TStroke;
	
	public int m;
	public int n;
	
	public DTW(final Vector<Point> RStroke, final Vector<Point> TStroke) {
		this.RStroke = RStroke;
		this.TStroke = TStroke;
		
		this.n = RStroke.size();
		this.m = TStroke.size();
	}
	
	public Matrix calcM() {
		//initialisation matrice
		final Matrix dtw = new Matrix(n, m);
		dtw.clear();
		
		//initialisation premiere ligne
		for(int i=1; i<n-1; i++) {
			dtw.items[i][1] = dtw.items[i-1][1] + distance(i, 1);
		}
		
		//initialisation premiere colonne
		for(int j=1; j<m-1; j++) {
			dtw.items[1][j] = dtw.items[1][j-1] + distance(1, j);
		}
		
		//calcul dwt
		for(int i=1; i<n-1; i++) {
			for(int j=1; j<m-1; j++) {
				//calcul du minimum
				double min = Math.min(dtw.items[i-1][j], dtw.items[i][j-1]);
				min = Math.min(min, dtw.items[i-1][j-1]);
				
				//determination de la position du minimum
				if(min == dtw.items[i-1][j])
					dtw.couple[i][j] = new Couple(i-1, j);
				else if(min == dtw.items[i][j-1])
					dtw.couple[i][j] = new Couple(i, j-1);
				else 
					dtw.couple[i][j] = new Couple(i-1, j-1);
				
				//calcul de dwt a la position i j
				dtw.items[i][j] = distance(i,j) + min;
			}
		}
		
		return dtw;
	}
	
	private double distance(final int i, final int j) {
		return RStroke.get(i).distance(TStroke.get(j));
	}
}
