function cte_dist(lambda, d)

global qdescs_norm
global dbdescs_norm
global dbnames
global qnames;

scoremat = zeros(length(dbdescs_norm), length(qdescs_norm));
for i = 1:length(dbdescs_norm)
    i
    db = dbdescs_norm{i};
    for j =1:length(qdescs_norm)
        q = qdescs_norm{j};
        scoremat(i,j) = max(calcS(q, db, lambda, d));
    end
end
save(['scoremat_' num2str(lambda) '_' num2str(d) '_.mat'], 'scoremat');

f = fopen(['resfile_' num2str(lambda) num2str(d) '_.dat'], 'w');
assert(f ~= -1)
  
for qno = 1:length(qdescs_norm)
  
  fprintf(f, '%s ', qnames(qno, :));
  
  [~, ids] = sort(scoremat(:, qno), 'descend');
  
  for j=1:length(ids)
    fprintf(f, '%s ', dbnames(ids(j), :));
  end

  fprintf(f, '\n');
  
end
fclose(f)
clear scoremat ;
end
