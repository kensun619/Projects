import java.util.ArrayList;
import java.util.List;

public class PerformanceAnalyser {
	
	List<Record> records; 
	
	public PerformanceAnalyser() {
		records = new ArrayList<Record>(); 
	}
	
	public static Record measure(NeuralNet model, Data test, boolean disp) {
		Record rc = new Record(); 
		rc.trainLoss = model.trainLoss; 
		rc.trainError = model.trainError; 
		rc.tuneError = model.tuneError; 
		double testError = 0; 
		for (int i = 0; i < test.size(); i++) {
			DataContainer inst = test.get(i); 
			Result maxOutput = Mat.max(model.predict(inst)); 
			Result maxY = Mat.max(inst.getLabel()); 
			if (maxOutput.idx[1] != maxY.idx[1])
				testError++; 
		}
		rc.testError = testError/test.size(); 
		if (disp) {
			System.out.print("Train Loss: " + String.format("%.4f", rc.trainLoss)); 
			System.out.print("\tTrain Error: " + String.format("%.4f", rc.trainError)); 
			System.out.print("\tTune Error: " + String.format("%.4f", rc.tuneError)); 
			System.out.println("\tTest Error: " + String.format("%.4f", rc.testError)); 
		}
		return rc; 
	}
	
	public void measure(NeuralNet model, Data test, boolean disp, int epoch) {
		Record rc = new Record(); 
		rc.trainLoss = model.trainLoss; 
		rc.trainError = model.trainError; 
		rc.tuneError = model.tuneError; 
		double testError = 0; 
		for (int i = 0; i < test.size(); i++) {
			DataContainer inst = test.get(i); 
			Result maxOutput = Mat.max(model.predict(inst)); 
			Result maxY = Mat.max(inst.getLabel()); 
			if (maxOutput.idx[1] != maxY.idx[1])
				testError++; 
		}
		rc.testError = testError/test.size(); 
		if (disp) {
			System.out.print("Train Loss: " + String.format("%.4f", rc.trainLoss)); 
			System.out.print("\tTrain Error: " + String.format("%.4f", rc.trainError)); 
			System.out.print("\tTune Error: " + String.format("%.4f", rc.tuneError)); 
			System.out.println("\tTest Error: " + String.format("%.4f", rc.testError)); 
		}
		
		rc.epoch = epoch; 
		records.add(rc); 
	}
	
	public static Mat confusionMatrix(NeuralNet model, Data test) {
		Mat matrix = new Mat(test.labelSize(),test.labelSize(), 0); 
		for (int instanceIdx = 0; instanceIdx < test.size(); instanceIdx++) {
			DataContainer inst = test.get(instanceIdx); 
			Result maxOutput = Mat.max(model.predict(inst)); 
			Result maxY = Mat.max(inst.getLabel()); 
			
			matrix.matrix[maxY.idx[1]][maxOutput.idx[1]]++; 
		}
		return matrix; 
	}
	
	public void printRecords(boolean includeDesciption) {
		if (includeDesciption) {
			for (int i = 0; i < records.size(); i++) {
				Record rc = records.get(i); 
				System.out.print("Epoch: " + rc.epoch); 
				System.out.print("\tTrain Loss: " + String.format("%.4f", rc.trainLoss)); 
				System.out.print("\tTrain Error: " + String.format("%.4f", rc.trainError)); 
				System.out.print("\tTune Error: " + String.format("%.4f", rc.tuneError)); 
				System.out.println("\tTest Error: " + String.format("%.4f", rc.testError)); 
			}
		} else {
			for (int i = 0; i < records.size(); i++) {
				Record rc = records.get(i); 
				System.out.print(rc.epoch); 
				System.out.print("\t" + String.format("%.4f", rc.trainLoss)); 
				System.out.print("\t" + String.format("%.4f", rc.trainError)); 
				System.out.print("\t" + String.format("%.4f", rc.tuneError)); 
				System.out.println("\t" + String.format("%.4f", rc.testError) + ";"); 
			}
		}
	}
	
	public void getROCs(NeuralNet model, Data test) {
		
	}
}

class Record {
	int epoch; 
	double trainLoss; 
	double trainError; 
	double tuneError; 
	double testError; 
	
	
	public int getEpoch(){
		return this.epoch;
	}
	
	public double getTrainLoss(){
		return this.trainLoss;
		
	}
	public double getTrainError(){
		return this.trainError;
		
	}
	public double getTuneError(){
		return this.tuneError;
		
	}
	
	public double getTestError(){
		return this.testError;
	}
	
	
	
}
