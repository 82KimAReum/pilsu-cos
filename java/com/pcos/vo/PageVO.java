package com.pcos.vo;

public class PageVO {
	private int count;// �� ������ ����
	private int page;// ���� ������
	private int pageStart;// index�� �Ѹ��� ������ ������ //���� �������� 12�ΰ�� 11.
	private int pageEnd;// index�� �Ѹ��� ���� ������//���� �������� 12�ΰ�� 20
	private int pageTotalEnd; // index�� ������ ������ ������
	// private String searchData;//ã�� ������ ������ ��
	private boolean pre = false;
	private boolean prepre = false;
	private boolean next = false;
	private boolean nextnext = false;

	public PageVO(int count, int page) {
		this.count = count;
		this.page = page;
		pageCalc();
	}

	public boolean isPre() {
		return pre;
	}

	public void setPre(boolean pre) {
		this.pre = pre;
	}

	public boolean isPrepre() {
		return prepre;
	}

	public void setPrepre(boolean prepre) {
		this.prepre = prepre;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public boolean isNextnext() {
		return nextnext;
	}

	public void setNextnext(boolean nextnext) {
		this.nextnext = nextnext;
	}

	public void pageCalc() {
		pageEnd = (int) (Math.ceil(page / (double) 10)) * 10;
		pageStart = (pageEnd - 10) + 1;
		pageTotalEnd = (int) (Math.ceil(count / (double) 12));
		
		if (page <= pageEnd) {
			next = true;
			if (pageEnd <= pageTotalEnd) {
				nextnext = true;
			}
		}
		if (pageEnd >= pageTotalEnd) {
			pageEnd = pageTotalEnd;
			next = false;
			nextnext = false;
		}
		if (page < pageEnd) {
			next = true;
		}
		if (page >= pageStart) {
			pre = true;
			if (page == 1)
				pre = false;
			if (pageStart > 10) {
				prepre = true;
			}
		}
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageStart() {
		return pageStart;
	}

	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getPageTotalEnd() {
		return pageTotalEnd;
	}

	public void setPageTotalEnd(int pageTotalEnd) {
		this.pageTotalEnd = pageTotalEnd;
	}

}
