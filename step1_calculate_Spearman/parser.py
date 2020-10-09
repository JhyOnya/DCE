import argparse


def parameter_parser_data(parser):
    # test data
    parser.add_argument('-d', '--data_name', type=str,
                        default='COAD',
                        choices=['COAD', 'KIRC', 'LUAD', 'THCA'],
                        help='choosing which data to test.')
    # seed
    parser.add_argument("--seed",
                        type=int,
                        default=6,
                        help="Random seed for sklearn pre-training. Default is 6.")

    parser.add_argument('-p', '--max_process',
                        type=int,
                        default=5,
                        help='if >1, use multiprocessing.')
    # path
    parser.add_argument('--index_path', type=str,
                        default="../dataset/gene_symbol_list_exceptSLC35E2",
                        help="choosing the index''s path.If not, please set '' .")

    args = parser.parse_args()

    parser.add_argument('--data_dir', type=str,
                        default="../dataset/" + args.data_name + "/",
                        help='choosing the data''s path.')

    parser.add_argument('--result_dir', type=str,
                        default="../cache/result_1to23/%s/" % (args.data_name),
                        help='choosing the data''s path.')


def parameter_parser_preTreat(parser):
    # pretreat messages
    parser.add_argument('--cut_value', type=int,
                        default=10,
                        help='remain features larger than.')


def parameter_parser_msg(parser):
    # test messages
    parser.add_argument('--fold_num', type=int,
                        default=10,
                        help='predict by 10 fold.')
    parser.add_argument('--remain_p_value', type=float,
                        default=0.01,
                        help='using p-value smaller than.')


def parameter_parser():
    parser = argparse.ArgumentParser()
    parameter_parser_preTreat(parser)
    parameter_parser_msg(parser)
    parameter_parser_data(parser)
    return parser.parse_args()
