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
		
		if(n == 0) {
			System.out.println("la taille de R est null");
			return null;
		}
		
		if(m == 0) {
			System.out.println("la taille de T est null");
			return null;
		}
		
		//initialisation matrice
		final Matrix dtw = new Matrix(n, m);
		dtw.clear();
		
		dtw.items[0][0] = 0;
		
		//initialisation premiere ligne
		for(int i=1; i<n; i++) {
			dtw.items[i][0] = dtw.items[i-1][0] + distance(i, 0);
		}
		
		//initialisation premiere colonne
		for(int j=1; j<m; j++) {
			dtw.items[0][j] = dtw.items[0][j-1] + distance(0, j);
		}
		
		//calcul dwt
		for(int i=1; i<n; i++) {
			for(int j=1; j<m; j++) {
				//calcul du minimum
				double min = Math.min(dtw.items[i-1][j], dtw.items[i][j-1]);
				min = Math.min(min, dtw.items[i-1][j-1]);
				
				//determination de la position du minimum
				if(min == dtw.items[i-1][j])
					dtw.couple[i][j] = new Couple(i-1, j);
				else if(min == dtw.items[i][j-1])
					dtw.couple[i][j] = new Couple(i, j-1);
				else if(min == dtw.items[i-1][j-1])
					dtw.couple[i][j] = new Couple(i-1, j-1);
				else 
					System.out.println("Erreur pas de correspondance");
				
				//calcul de dwt a la position i j
				dtw.items[i][j] = distance(i,j) + min;
			}
		}
		
		return dtw;
	}
	
	/** Calcul de la distance entre deux points
	 * @param i index du point de reference
	 * @param j index du point de courbe de l'utilisateur
	 * @return la distance entre les deux points
	 */
	private double distance(final int i, final int j) {
		return RStroke.get(i).distance(TStroke.get(j));
	}
}
