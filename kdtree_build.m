% --------------------------kdtree_build.m---------------------------------
% A function to build a k-d tree database from keypoints in an array.
%  struct kd_node
% {
%  int ki;                      /**< partition key index */
%  double kv;                   /**< partition key value */
%  int leaf;                    /**< 1 if node is a leaf, 0 otherwise */
%  struct feature* features;    /**< features at this node */
%  int n;                       /**< number of features */
%  struct kd_node* kd_left;     /**< left child */
%  struct kd_node* kd_right;    /**< right child */
% };
% ---------------------

function kd_root = kdtree_build(features, n)

if n <= 0
   kd_root = 0;
   return
end

kd_root = kd_node_init(features, n);
kd_root = expand_kd_node_subtree(kd_root);

end