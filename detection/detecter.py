import tensorflow as tf
import numpy as np

from utils import label_map_util
from utils import visualization_utils as vis_util

class Detecter:
    def __init__(self):
        self.detection_graph = tf.Graph()
    
    def setup(self, model_file, label_map_file):
        self.load_model(model_file)
        self.load_label_map(label_map_file)
        self.prepare_tensors()

        self.sess = tf.Session(graph=self.detection_graph)

    def load_model(self, model_file) :
        with self.detection_graph.as_default():
            od_graph_def = tf.GraphDef()
            with tf.gfile.GFile(model_file, 'rb') as fid:
                serialized_graph = fid.read()
                od_graph_def.ParseFromString(serialized_graph)
                tf.import_graph_def(od_graph_def, name='')

    def load_label_map(self, label_map_file):
        self.category_index = label_map_util.create_category_index_from_labelmap(label_map_file, use_display_name=True)

    def prepare_tensors(self):
        
        self.image_tensor = self.detection_graph.get_tensor_by_name('image_tensor:0')
        
        self.detection_boxes = self.detection_graph.get_tensor_by_name('detection_boxes:0')
        
        self.detection_scores = self.detection_graph.get_tensor_by_name('detection_scores:0')
        
        self.detection_classes = self.detection_graph.get_tensor_by_name('detection_classes:0')
        
        self.num_detections = self.detection_graph.get_tensor_by_name('num_detections:0')

    def detect(self, image, threshold=None):
        tensors = [self.detection_boxes, self.detection_scores, self.detection_classes, self.num_detections]
        (boxes, scores, classes, num) = self.sess.run(tensors, feed_dict={self.image_tensor: image})
        (boxes, scores, classes) = (np.squeeze(boxes), np.squeeze(scores), np.squeeze(classes).astype(np.uint8))
        return (boxes, scores, classes, num)
        
    def visualize(self, image, boxes, classes, scores, threshold):
        vis_util.visualize_boxes_and_labels_on_image_array(
            image, boxes, classes, scores, self.category_index,
            use_normalized_coordinates=True,
            line_thickness=8,
            min_score_thresh=threshold)

    def get_found(self):
        return vis_util.get_found()

    if __name__ == "__main__":
        detecter = Detecter()
        detecter.setup('./frozen_inference_graph.pb', './object-detection.pbtxt')
       
        print(detecter.category_index)
        
        print(detecter.image_tensor)
        print(detecter.detection_boxes)
        print(detecter.detection_scores)
        print(detecter.detection_classes)
        print(detecter.num_detections)