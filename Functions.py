import sqlite3 as sql
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

chart_colors = sns.color_palette("BuGn", 3)


def sql_connection(db_path, query):
    """
    Connects to SQLite database, executes a query and returns the result as a DataFrame.

    Parameters:
    - db_path (str): Path to the SQLite database file.
    - query (str): SQL query to execute.

    Returns:
    - pd.DataFrame: The result of the query as a pandas DataFrame.
    """

    connection = sql.connect(db_path)
    result = pd.read_sql(query, connection)
    connection.close()

    result = result.map(lambda x: x.title().strip() if isinstance(x, str) else x)

    return result


def respondents_percentage(data, x, y, z):
    """
    Function to plot a bar chart with the percentage of respondents based on the given columns.

    Parameters:
    - data: DataFrame containing the survey data
    - x: Column name for the x-axis
    - y: Column name for the y-axis
    - z: Column name to sum for the total number of respondents
    """

    total_users = data[z].sum()

    plt.subplots(figsize=(15, 5))

    ax = sns.barplot(
        data=data, x=x, y=y, color=chart_colors[1], edgecolor="black", alpha=0.7
    )

    ax.set_title(
        "Percentages of Respondents by Year", fontsize=16, fontweight="bold", pad=20
    )
    ax.set_xlabel("Year of Survey", labelpad=20, fontsize=14)
    ax.set_ylabel("Percentage of Respondents", labelpad=20, fontsize=14)
    ax.tick_params(axis="both", labelsize=12)
    ax.grid(True, linestyle="--", alpha=0.2)
    ax.text(
        1,
        1,
        f"Total Respondents: {total_users: }",
        ha="right",
        va="top",
        fontsize=16,
        fontweight="bold",
        transform=ax.transAxes,
    )

    for axis in ax.containers:
        ax.bar_label(
            axis,
            label_type="edge",
            fontsize=14,
            color="black",
            fontweight="bold",
            fmt="{:,.2f} %",
        )

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def respondents_distribution(data, x):
    """ """
    fig, ax = plt.subplots(2, 1, figsize=(15, 8))

    avg = data[x].mean()
    mode = data[x].mode()[0]
    median = data[x].median()

    sns.histplot(data=data, x=x, kde=True, ax=ax[0], color=chart_colors[1])

    ax[0].axvline(
        avg, color="blue", linestyle="--", label=f"Average: {avg:.2f}", linewidth=2
    )
    ax[0].axvline(
        mode, color="red", linestyle="-", label=f"Mode: {mode:.2f}", linewidth=2
    )
    ax[0].axvline(
        median, color="black", linestyle="-", label=f"Median: {median:.2f}", linewidth=3
    )

    sns.boxplot(
        data=data,
        x=x,
        color=chart_colors[1],
        medianprops=dict(color="red", linewidth=2),
        capprops=dict(color="red", linewidth=2),
        ax=ax[1],
    )

    fig.suptitle("Distribution of Respondents by Age", fontsize=16, fontweight="bold")

    for axis in ax:
        axis.set_ylabel(None)
        axis.tick_params(axis="y", labelsize=10)
        axis.grid(axis="y", linestyle="--", alpha=0.3)

    tick_values = range(0, 75, 5)
    ax[0].ticklabel_format(style="plain", axis="x")
    ax[0].set_xlabel(None)
    ax[0].set_xticks(tick_values)
    ax[0].legend(fontsize=14)
    ax[1].set_xlabel("Respondents Age", labelpad=10, fontsize=16)
    ax[1].set_xticks(tick_values)

    sns.despine(top=True, right=True)

    plt.tight_layout()
    plt.show()


def respondents_career_level_percentage(data, x, y, z):
    """ """

    total_users = data[z].sum()

    plt.subplots(figsize=(15, 5))

    ax = sns.barplot(
        data=data, x=x, y=y, color=chart_colors[1], edgecolor="black", alpha=0.7
    )

    ax.set_title(
        "Percentages of Respondents by Career Level",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    ax.set_xlabel("Carrer level", labelpad=20, fontsize=14)
    ax.set_ylabel("Percentages of Respondents", labelpad=20, fontsize=14)
    ax.tick_params(axis="both", labelsize=12)
    ax.grid(True, linestyle="--", alpha=0.2)
    ax.text(
        1,
        1,
        f"Total Respondents: {total_users}",
        ha="right",
        va="top",
        fontsize=16,
        fontweight="bold",
        transform=ax.transAxes,
    )

    for axis in ax.containers:
        ax.bar_label(
            axis,
            label_type="edge",
            fontsize=14,
            color="black",
            fontweight="bold",
            fmt="{:,.2f} %",
        )

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def respondents_gender_percentage(data, x, y, z):
    """ """

    total_users = data[z].sum()

    plt.subplots(figsize=(15, 5))

    ax = sns.barplot(
        data=data, x=x, y=y, color=chart_colors[1], edgecolor="black", alpha=0.7
    )

    ax.set_title(
        "Percentages of Respondents by Gender", fontsize=16, fontweight="bold", pad=20
    )
    ax.set_xlabel("Gender", labelpad=20, fontsize=14)
    ax.set_ylabel("Percentages of Respondents", labelpad=20, fontsize=14)
    ax.tick_params(axis="both", labelsize=12)
    ax.grid(True, linestyle="--", alpha=0.2)
    ax.text(
        1,
        1,
        f"Total Respondents: {total_users}",
        ha="right",
        va="top",
        fontsize=16,
        fontweight="bold",
        transform=ax.transAxes,
    )

    for axis in ax.containers:
        ax.bar_label(
            axis,
            label_type="edge",
            fontsize=14,
            color="black",
            fontweight="bold",
            fmt="{:,.2f} %",
        )

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def respondents_continent_percentage(data, x, y, z):
    """ """

    total_users = data[z].sum()

    plt.subplots(figsize=(15, 5))

    ax = sns.barplot(
        data=data, x=x, y=y, color=chart_colors[1], edgecolor="black", alpha=0.7
    )

    ax.set_title(
        "Percentages of Respondents by Continent",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    ax.set_xlabel("Continent", labelpad=20, fontsize=14)
    ax.set_ylabel("Percentages of Respondents", labelpad=20, fontsize=14)
    ax.tick_params(axis="both", labelsize=12)
    ax.grid(True, linestyle="--", alpha=0.2)
    ax.text(
        1,
        1,
        f"Total Respondents: {total_users}",
        ha="right",
        va="top",
        fontsize=16,
        fontweight="bold",
        transform=ax.transAxes,
    )

    for axis in ax.containers:
        ax.bar_label(
            axis,
            label_type="edge",
            fontsize=14,
            color="black",
            fontweight="bold",
            fmt="{:,.2f} %",
        )

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def us_or_other_country(data, x, y, z):
    """ """
    total_users = data[z].sum()

    plt.subplots(figsize=(15, 5))

    ax = sns.barplot(
        data=data, x=x, y=y, color=chart_colors[1], edgecolor="black", alpha=0.7
    )

    ax.set_title(
        "Percentages of Respondents working in United States",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    ax.set_xlabel("")
    ax.set_ylabel("Percentages of Respondents", labelpad=20, fontsize=14)
    ax.tick_params(axis="both", labelsize=14)
    ax.grid(True, linestyle="--", alpha=0.2)
    ax.text(
        1,
        1,
        f"Total Respondents: {total_users}",
        ha="right",
        va="top",
        fontsize=16,
        fontweight="bold",
        transform=ax.transAxes,
    )

    for axis in ax.containers:
        ax.bar_label(
            axis,
            label_type="edge",
            fontsize=14,
            color="black",
            fontweight="bold",
            fmt="{:,.2f} %",
        )

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def mental_health_top(data, x, y):
    """ """

    plt.subplots(figsize=(15, 5))

    ax = sns.barplot(
        data=data, x=x, y=y, color=chart_colors[1], edgecolor="black", alpha=0.7
    )

    ax.set_title(
        "Percentages of Respondents by Mental Health Issues",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    ax.set_xlabel("")
    ax.set_ylabel("Mental Health Issues", labelpad=20, fontsize=14)
    ax.tick_params(axis="both", labelsize=14)
    ax.grid(True, linestyle="--", alpha=0.2)

    for axis in ax.containers:
        ax.bar_label(
            axis,
            label_type="edge",
            fontsize=14,
            color="black",
            fontweight="bold",
            padding=5,
            fmt="{:,.2f} %",
        )

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def mental_health_gender(data, x, y, z):
    """ """
    
    pivot_data = data.pivot(index=x, columns=y, values=z)
    
    ax = pivot_data.plot(
        kind="bar", stacked=True, figsize=(12, 6), edgecolor="black", colormap="rocket"
    )

    ax.set_title(
        "Top 5 Mental Health Issues by Gender",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    ax.set_xlabel("")
    ax.set_ylabel("Percentage of Respondents", fontsize=14, labelpad=10)
    ax.legend(
        title="Mental Health Issues",
        fontsize=12,
        title_fontsize=14,
        bbox_to_anchor=(1.02, 0.5),
        loc="center left",
        frameon=False,
    )
    ax.tick_params(axis="both", labelsize=14)
    ax.grid(True, linestyle="--", alpha=0.2)
    ax.set_xticklabels(pivot_data.index, rotation=45)

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def mental_health_tech(data, x, y, z):
    """ """
    pivot_data = data.pivot(index=x, columns=y, values=z)
    ax = pivot_data.plot(
        kind="bar", stacked=True, figsize=(12, 6), edgecolor="black", colormap="rocket"
    )

    ax.set_title(
        "Top 5 Mental Health Issues in Tech Company by Gender ",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    ax.set_xlabel("")
    ax.set_ylabel("Percentage of Respondents", fontsize=14, labelpad=10)
    ax.legend(
        title="Mental Health Issues",
        fontsize=12,
        title_fontsize=14,
        bbox_to_anchor=(1.02, 0.5),
        loc="center left",
        frameon=False,
    )
    ax.tick_params(axis="both", labelsize=14)
    ax.grid(True, linestyle="--", alpha=0.2)
    ax.set_xticklabels(pivot_data.index, rotation=45)

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def mental_health_top_conf(data, x, y, conf_low, conf_upp):

    plt.figure(figsize=(15, 8))

    plt.bar(
        data[x],
        data[y],
        yerr=[data[y] - data[conf_low], data[conf_upp] - data[y]],
        capsize=5,
        color=chart_colors[1],
        edgecolor="black",
    )

    plt.title(
        "Proportion of Mental Health Issues with Confidence Intervals",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    plt.xlabel("")
    plt.ylabel("Proportion, % (Confidence level)", fontsize=14, labelpad=10)
    plt.xticks(rotation=45, ha="right", fontsize=12)
    plt.tick_params(axis="both", labelsize=14)
    plt.grid(True, linestyle="--", alpha=0.2)

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()


def productivity_level_conf(data, x, y, conf_low, conf_upp):

    plt.figure(figsize=(15, 5))

    plt.bar(
        data[x],
        data[y],
        yerr=[data[y] - data[conf_low], data[conf_upp] - data[y]],
        capsize=5,
        color=chart_colors,
        edgecolor="black",
    )

    plt.title(
        "Proportion of Mental Health Impact to Productivity Levels",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    plt.xlabel("")
    plt.ylabel("Proportion, % (Confidence level)", fontsize=14, labelpad=10)
    plt.xticks(rotation=45, ha="right", fontsize=12)
    plt.tick_params(axis="both", labelsize=14)
    plt.grid(True, linestyle="--", alpha=0.2)

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()
    
    
def affected_carrer_conf(data, x, y, conf_low, conf_upp):

    plt.figure(figsize=(15, 5))

    plt.bar(
        data[x],
        data[y],
        yerr=[data[y] - data[conf_low], data[conf_upp] - data[y]],
        capsize=5,
        color=chart_colors,
        edgecolor="black",
    )

    plt.title(
        "Mental Health Impact on Career",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    plt.xlabel("")
    plt.ylabel("Proportion, % (Confidence level)", fontsize=14, labelpad=10)
    plt.xticks(rotation=45, ha="right", fontsize=12)
    plt.tick_params(axis="both", labelsize=14)
    plt.grid(True, linestyle="--", alpha=0.2)

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()
    
    
def discuss_with_employee_conf(data, x, y, conf_low, conf_upp):

    plt.figure(figsize=(15, 5))

    plt.bar(
        data[x],
        data[y],
        yerr=[data[y] - data[conf_low], data[conf_upp] - data[y]],
        capsize=5,
        color=chart_colors,
        edgecolor="black",
    )

    plt.title(
        "Whether Respondents Discuss Mental Health Issues with Their Employeer",
        fontsize=16,
        fontweight="bold",
        pad=20,
    )
    plt.xlabel("")
    plt.ylabel("Proportion, % (Confidence level)", fontsize=14, labelpad=10)
    plt.xticks(rotation=45, ha="right", fontsize=12)
    plt.tick_params(axis="both", labelsize=14)
    plt.grid(True, linestyle="--", alpha=0.2)

    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.show()
    