import java.util.Random;

public class LinearActivationLayer implements ANNLayer {

	private boolean set; 
	private double dropOutRate, dropOutCorrection; 
	Random rnd = new Random(); 
	private Mat dropOutMask; 
	
	public LinearActivationLayer(double dropOutRate) {
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
			return new DataContainer(input.eleWiseMul(dropOutMask)); 
		} else {
			return new DataContainer(input.scale(dropOutCorrection)); 
		}
	}

	@Override
	public DataContainer backProp(DataContainer backPropError, double learningRate) {
		// TODO Auto-generated method stub
		
		Mat error = backPropError.getVec(); 
		Mat output = dropOutMask.eleWiseMul(error); 
		
		return new DataContainer(output);
	}

	@Override
	public ANNLayer copy() {
		// TODO Auto-generated method stub
		return this; 
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
