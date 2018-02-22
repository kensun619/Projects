import java.util.List;

public interface ANNLayer {
	public DataContainer forwardProp(DataContainer forwardPropData, boolean training); 
	public DataContainer backProp(DataContainer backPropError, double learningRate); 
	public ANNLayer copy(); 
}

class DataContainer {
	private List<Mat> imgs; 
	private Mat vector; 
	private Mat label = null; 
	
	public DataContainer(Mat vector) {
		this.vector = vector; 
		imgs = null; 
	}
	public DataContainer(List<Mat> imgs) {
		this.imgs = imgs; 
		vector = null; 
	}
	
	public List<Mat> getImgs() {
		if (imgs == null) {
			throw new RuntimeException("Error: Trying to get image list"); 
		}
		return imgs; 
	}
	public Mat getVec() {
		if (vector == null) {
			throw new RuntimeException("Error: Trying to get vector"); 
		}
		return vector; 
	}
	
	public void setLabel(Mat rowVec) {
		this.label = rowVec; 
	}
	public Mat getLabel() {
		if (label == null) {
			throw new RuntimeException("This container does not contain label"); 
		}
		return label; 
	}
}
