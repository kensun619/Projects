import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

public class Data {
	private List<DataContainer> instance; 
	private int numLabels; 
	
	public Data() {
		instance = new ArrayList<DataContainer>(); 
	}
	
	public int size() {
		return instance.size(); 
	}
	
	public int labelSize() {
		return numLabels;
	}
	
	public DataContainer get(int idx) {
		return instance.get(idx); 
	}
	
	public void shuffle() {
		Collections.shuffle(instance);
	}
	
	public void add(Mat instance) {
		this.instance.add(new DataContainer(instance)); 
	}
	
	public void loadData(Vector<Vector<Double>> dataVectors, int numLabels) {
		for (int i = 0; i < dataVectors.size(); i++) {
			Mat inst = new Mat(1, dataVectors.get(0).size()-1); 
			for (int j = 0; j < inst.size[1]; j++) {
				inst.matrix[0][j] = dataVectors.get(i).get(j); 
			}
			Mat label = new Mat(1, numLabels, 0); 
			double idx = dataVectors.get(i).get(inst.size[1]); 
			label.matrix[0][(int)idx] = 1; 
			DataContainer result = new DataContainer(inst); 
			result.setLabel(label);
			this.instance.add(result); 
			this.numLabels = numLabels; 
		}
	}
	
	public void addInstance(DataContainer inst) {
		instance.add(inst); 
		numLabels = inst.getLabel().size[1]; 
	}
	
}
