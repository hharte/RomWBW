�Z3ENV   e*	�sY��!� "S+^T~�Q| +~� /(~+�//(|28 t�g '��
SETPATH, Version 1.1  :! �r��
*] }�/ |� (���
  SETPATH allows the user to display or modify the symbolic search path for
  transient programs.  Path elements may be expressed using drive-user (DU)
  or named-directory (DIR) form.  The character "$" may be used with the DU
  form to indicate the current drive or user (e.g., "B$" or "$2" or "$$").
  SETPATH sets or clears the program error flag.  Command syntax is:
 �r��                <-- Display Current Path �r�� //             <-- Print This Help Screen �r�� element-list   <-- Set New Path to element-list �r�� [option element-list]....[option element-list]

  Where the option may be any of the following:

    /c          <-- Clear path and set to new element-list
    /p          <-- Prefix element-list to beginning of path
    /a          <-- Append element-list to end of path
    /d          <-- Delete element-list from path starting at beginning
    /r          <-- Remove element-list from path starting from the end

  A trailing "q" or "/q" mandates quiet operation ���
     ô/P/A/D/C/R͌2:"Q /�g ��
 - Abort: No Path �>��g��
��S�{Y�͛�M�g ��
 - Abort: No Wheel >��g '��
 - Abort: Illegal option -  !� ��>��g $��

  Input resulted in null path >��g /��
 - Abort: Too many paths for buffer !� ��>��g (��
 - Abort: Too many paths  -  !� ��>��g -��
 - Abort: Too many head paths  -  !� ��>��g -��
 - Abort: Too many tail paths  -  !� ��>��g ��
Bad Expression at  *U��>	�> x� �ɯ�S*:g)�:�*"E"G"I"O#"K##"M#� �KE�BDM! �B/��[E�RDM�C*Ow272>2?2=2;2@*M"W*I"C*G"A*Q�	y2;�2<�[K*Q�;*S�"S��I
�[S��(>C29�z	!
���*S~�/(:�29�"S�z	:@2=�2@*Ww*M"W:9�C(�P(�D(i�R���A(6���4
:=_:>�2>!:�Ұ*A�_�W�R"A�*M�;*S~��	��:=_:?�2?!:����[C*M�;�"C*S~�(y���[M*K:<G��̽� �~��w*K�*S~�(L��*M�	y�(+�*K :<=O	:<G�D�	�  �*S~�(��+~��w*K� ##~� ���[M::�O �C:9�C�W	�[M*E::O�~� (��4
#x��~#�##�*K�:<�� O*G� 
w#x� ���*S�"S~�(����:@!:�*S�G<2@"U~�$(*�A8`G�fOx�0W#~�$(�:(� (�(�08B�:0>#~��[W*U~�$(�@#~#�$(+��
�
�}<Gy��
~�: #"S�"W�z	*U�� �*Wp#q#"W*U~#�(�  �+"S�z	�[Q*M~���(����g���
  Symbolic     DU        DIR
 *Q~��"W*W# �C~�$(�@#~�$ �j>:��#*W~�$ x<�@#~�$ y�j>:*W-~�$(G#~�$(O#"W�� >:��
!���~��x
�g���
 � ~�08�
0Gy�؇؁؇؀�O#��~#� (�+��1 !4~� �#��Noname ~���������x�8���� + ����������+������:8�ʓ�����o(Type  �8�o at  ��͛�oH) ��!�~�����_(# ������        ��͕(~� (ͼ#�����[~�8#�~#�0�+> ��[ͅ(~�(��##� #���F#N>������� 	����0��:8	�A��[87�7?�ͅ ��~�(��# 	~� #���� 	������n ü�$ �r��, ì�" *c~#fo�����- ì� ���	 ����( ì��*c) ^#V���*c|�(~���*c�w���*c|�(^#V#~�ѷ�"c�����/�� �/O�G����������� ~#� ����	(ͼ�(��
(	�(� ����y/�<G> ͼ����� �ѷ�����&d�N&
�N�b����.��,0��g}� �|�> (��0Gͼ|�����&d̀&
̀͔����.��,0��g}� �|�> (��0G|��|ͦ}ͦ����ͼ���ͼ������O>�������x�8���� # ����������#��������a��{��_���������o��* o���Ɛ'�@'�                                                                                                            