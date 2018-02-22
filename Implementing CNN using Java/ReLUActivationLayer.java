import java.util.Random;

public class ReLUActivationLayer implements ANNLayer {

	private boolean set; 
	private double dropOutRate, dropOutCorrection; 
	Random rnd = new Random(); 
	private Mat dropOutMask; 
	
	private Mat lastOutputDroped; 
	
	public ReLUActivationLayer(double dropOutRate) {
		this.dropOutRate = dropOutRate; 
	}
	
	@Override
	public DataContainer forwardProp(DataContainer forwardPropData, boolean training) {
		// TODO Auto-generated method stub
		Mat input = forwardPropData.getVec(); 
		
		if (!set) {
			dropOutMask = new Mat(1, input.size[1], 1); 
			for (int i = 0; i < (int)((double)input.size[1] * dropOutRate); i++) {
				dropOutMask.matrix[0][i] = 0; 
			}
			this.dropOutCorrection = 1 - ((int)((double)input.size[1] * dropOutRate)) / ((double) input.size[1]); 
			set = true; 
		}
		
		if (training) {
			shuffleDropOutMask(); 
			lastOutputDroped = activate(input).eleWiseMul(dropOutMask); 
			return new DataContainer(lastOutputDroped); 
		} else {
			lastOutputDroped = null; 
			return new DataContainer(activate(input).scale(dropOutCorrection)); 
		}
	}

	@Override
	public DataContainer backProp(DataContainer backPropError, double learningRate) {
		// TODO Auto-generated method stub
		if (lastOutputDroped == null) {
			throw new RuntimeException("Invalid operation"); 
		}
		
		Mat error = backPropError.getVec(); 
		Mat output = derivative(lastOutputDroped).eleWiseMul(dropOutMask).eleWiseMul(error); 
		
		return new DataContainer(output);
	}

	@Override
	public ANNLayer copy() {
		// TODO Auto-generated method stub
		return this; 
	}

	private Mat activate(Mat input) {
		Mat output = new Mat(input.size[0], input.size[1]);
		for (int i = 0; i < input.size[1]; i++) {
			if (input.matrix[0][i] <= 0)
				output.matrix[0][i] = 0; 
			else
				output.matrix[0][i] = input.matrix[0][i]; 
 		}
		return output; 
	}
	
	private Mat derivative(Mat input) {
		Mat result = new Mat(input.size[0], input.size[1]);
		for (int i = 0; i < input.size[1]; i++) {
			if (input.matrix[0][i] <= 0)
				result.matrix[0][i] = 0; 
			else
				result.matrix[0][i] = 1; 
 		}
		return result; 
	}
	
	private void shuffleDropOutMask() {
		double swap; 
		for (int i = dropOutMask.size[1] - 1; i >= 1; i--) {
			int rndIdx = rnd.nextInt(i+1); 
			swap = dropOutMask.matrix[0][rndIdx]; 
			dropOutMask.matrix[0][rndIdx] = dropOutMask.matrix[0][i]; 
			dropOutMask.matrix[0][i] = swap; 
		}
    }
}
